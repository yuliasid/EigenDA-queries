/*
viz: Staked area chart / bar chart/ Line chart/ Table
query calculates the top-10 operators for TODAY and shows its balance dynamic
*/

WITH
  OperatorBalances AS (
    SELECT
      bytearray_ltrim (bytearray_substring (topic1, 1, 32)) AS operator,
      date(block_time) AS date,
      SUM(
        bytearray_to_uint256 (bytearray_substring (data, 1 + (32 * 2), 32)) / 1e18
      ) AS balance
    FROM
      ethereum.logs
    WHERE
      topic0 = 0x1ec042c965e2edd7107b51188ee0f383e22e76179041ab3a9d18ff151405166c
      AND tx_to = 0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A
    GROUP BY
      1,
      2
  ),
  CumulativeBalances AS (
    SELECT
      operator,
      date,
      SUM(balance) OVER (
        PARTITION BY
          operator
        ORDER BY
          date
      ) AS cumulative_balance
    FROM
      OperatorBalances
  ),
  LatestBalances AS (
    SELECT
      operator,
      MAX(date) AS latest_date
    FROM
      CumulativeBalances
    GROUP BY
      operator
  ),
  TopOperators AS (
    SELECT
      cb.operator,
      cb.cumulative_balance
    FROM
      CumulativeBalances cb
      JOIN LatestBalances lb ON cb.operator = lb.operator
      AND cb.date = lb.latest_date
    ORDER BY
      cb.cumulative_balance DESC
    LIMIT
      10
  )
SELECT
  ob.operator AS operator_address,
  onames.name AS operator_name,
  ob.date AS date,
  ob.cumulative_balance
FROM
  CumulativeBalances ob
  JOIN TopOperators top ON ob.operator = top.operator
  LEFT JOIN query_3622950 onames ON ob.operator = onames.operator
ORDER BY
  top.cumulative_balance,
  ob.date;
