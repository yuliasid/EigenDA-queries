/*
table shows balances (LST and Native restaked ETH) of operators
*/

SELECT
    x.operator,
    COALESCE(q.name, '') AS name,  -- Joining names and using empty string as default if no name is found
    SUM(x.shares) AS balance,
    COUNT(x.staker) AS delegator
FROM
    (
        SELECT DISTINCT
            bytearray_ltrim(bytearray_substring(data, 13, 20)) AS staker,
            bytearray_ltrim(bytearray_substring(topic1, 1, 40)) AS operator,
            bytearray_to_uint256(bytearray_substring(data, 65, 32)) / 1e18 AS shares
        FROM
            ethereum.logs
        WHERE
            topic0 = 0x1ec042c965e2edd7107b51188ee0f383e22e76179041ab3a9d18ff151405166c
    ) AS x
LEFT JOIN
    query_3622950 q ON q.operator = x.operator
GROUP BY
    x.operator, q.name
ORDER BY
    balance DESC;


