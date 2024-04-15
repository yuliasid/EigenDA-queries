/*
Total count of AVS operators
*/
SELECT COUNT(Distinct tx_from)  as operator_num
FROM ethereum.logs
WHERE
    topic0 = 0xf0952b1c65271d819d39983d2abb044b9cace59bcc4d4dd389f586ebdcb15b41
    AND bytearray_substring(topic2, 13, 20) IN (
        0x870679e138bcdf293b7ff14dd44b70fc97e12fc0, --eigenda,
        0x23221c5bB90C7c57ecc1E75513e2E4257673F0ef, -- eoracle
        0xd25c2c5802198cb8541987b73a8db4c9bcae5cc7, -- witness chain
        0x71a77037870169d47aad6c2c9360861a4c0df2bf, -- AltLayer MACH
        0x9fc952bdcbb7daca7d420fa55b942405b073a89d, --Brevis coChain AVS
        0x6026b61bdd2252160691cb3f6005b6b72e0ec044, --Powered by AltLayer
        0x35f4f28a8d3ff20eed10e087e8f96ea2641e6aa2 --Lagrange State Committees
        ) 
   
