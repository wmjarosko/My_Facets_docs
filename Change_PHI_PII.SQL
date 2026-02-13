
SELECT GRGR_CK
FROM CMC_GRGR_GROUP
WHERE GRGR_ID = 'YOUR_TARGET_GROUP_ID';

Execute an update on the Member table. Do not alter the MEME_CK, as this is the internal system link to claims, accumulators, and history.

UPDATE CMC_MEME_MEMBER
SET
MEME_LAST_NAME = 'REDACTED',
MEME_FIRST_NAME = 'REDACTED',
MEME_MID_INIT = NULL,
MEME_SSN = '000000000', -- Or NULL, depending on constraints
MEME_HICN = NULL, -- Medicare HICN
MEME_MEDCD_NO = NULL, -- Medicaid Number
MEME_BIRTH_DT = '1900-01-01', -- Reset DOB to a default or offset date
MEME_ID_NAME = 'REDACTED' -- 5-char search key
WHERE GRGR_CK = (SELECT GRGR_CK FROM CMC_GRGR_GROUP WHERE GRGR_ID = 'YOUR_TARGET_GROUP_ID');

Do not update MEME_REL (Relationship) or MEME_SEX if you wish to maintain rating logic, though removing them strips PII.

Address data is linked via the Subscriber Contrived Key (SBSB_CK). Identify the subscribers belonging to the target group before updating addresses.

UPDATE CMC_SBAD_ADDR
SET
SBAD_ADDR1 = 'REDACTED ADDRESS',
SBAD_ADDR2 = NULL,
SBAD_CITY = 'REDACTED',
SBAD_ZIP = '00000'
WHERE SBSB_CK IN (
SELECT SBSB_CK
FROM CMC_SBSB_SUBSC
WHERE GRGR_CK = (SELECT GRGR_CK FROM CMC_GRGR_GROUP WHERE GRGR_ID = 'YOUR_TARGET_GROUP_ID')
);

The SBSB_ID itself is often considered PII (e.g., if it is an SSN). However, it is also a key used for looking up members. This can have downstream effects to External Systems.

ErCmcRunSbid converts Subscriber IDs from SSN-based IDs to generated IDs while maintaining system integrity.

Facets relies on Contrived Keys (e.g., MEME_CK, GRGR_CK, SBSB_CK) for internal joins. The SQL updates descriptive columns and does not delete rows or modify columns ending in _CK, the system relationships (claims history, accumulators, etc.) will remain intact.

SYSTEM_MASKING product parameter can be configured to mask SSNs, Tax IDs, and Medicare numbers in the UI without running SQL against the database.

Modifying these tables via SQL may create entries in the Facets Audit tables (audit.CMC_MEME_MEMBER, etc.) if auditing is enabled. These audit trails will contain the "Before" image (the real PHI). Truncating data for the specific groups from the audit table is recommended.