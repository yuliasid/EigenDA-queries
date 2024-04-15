/*
Total amount of EigenDA operators
*/

SELECT COUNT(Distinct tx_from)  as operator_num
FROM ethereum.logs
WHERE
    topic0 = 0xf0952b1c65271d819d39983d2abb044b9cace59bcc4d4dd389f586ebdcb15b41
    AND bytearray_substring(topic2, 13, 20) = 0x870679e138bcdf293b7ff14dd44b70fc97e12fc0 --eigenda
