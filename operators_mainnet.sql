/*
list of all operators on mainnet
*/

SELECT distinct tx_from as operator_num,
       date(block_time) as date
FROM ethereum.logs
WHERE topic0 = 0x8e8485583a2310d41f7c82b9427d0bd49bad74bb9cff9d3402a29d8f9b28a0e2
ORDER BY 2 DESC
