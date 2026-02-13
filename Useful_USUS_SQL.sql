
Summary Schema Relationship User 

(USUS) $\leftrightarrow$ User-Group Link (USSG) $\leftrightarrow$ Security Group (SEGR)USUS_ID: The specific user (e.g., JDOE).SEGR_ID: The role/group (e.g., CLM_ADJ for Claims Adjuster).Permissions: Defined within the SEGR record to allow/deny actions on specific tables or windows.Next Step:If you have access to the Facets SQL backend, you can run a query like SELECT * FROM CMC_USUS_USER WHERE USUS_ID = 'YourID' to see the specific configuration for a user.

SQL queries to inspect a user's security configuration. These queries join the User table with the relevant Group tables to show you exactly what permissions a specific User ID has.

1. Query for Security Groups (Data Access)
This query shows which Security Groups a user belongs to. These groups control permissions (Read/Write/Delete) on specific data.

SQL

SELECT 
    U.USUS_ID AS User_ID,
    U.USUS_NAME AS User_Name,
    S.SEGR_ID AS Security_Group_ID,
    S.SEGR_DESC AS Description
FROM 
    CMC_USUS_USER U
JOIN 
    CMC_USSG_USER_SEC_GRP Link ON U.USUS_ID = Link.USUS_ID
JOIN 
    CMC_SEGR_SEC_GRP S ON Link.SEGR_ID = S.SEGR_ID
WHERE 
    U.USUS_ID = 'ENTER_USER_ID_HERE';
2. Query for Application Groups (Menu Access)
This query shows which Application Groups a user belongs to. These groups control which modules and windows appear in the user's Facets toolbar.

SQL

SELECT 
    U.USUS_ID AS User_ID,
    A.APGR_ID AS App_Group_ID,
    A.APGR_DESC AS Description
FROM 
    CMC_USUS_USER U
JOIN 
    CMC_USAG_USER_APP_GRP Link ON U.USUS_ID = Link.USUS_ID
JOIN 
    CMC_APGR_APP_GRP A ON Link.APGR_ID = A.APGR_ID
WHERE 
    U.USUS_ID = 'ENTER_USER_ID_HERE';
Quick Tips for these Tables
CMC Prefix: Most Core Facets tables begin with CMC_. If you are looking for custom tables or extensions, they might have a different prefix (like X_).

Active Status: You may want to check if a user is technically "deleted" or inactive. In the CMC_USUS_USER table, check the USUS_MNT_TYPE column. usually, a value of D indicates a deleted/inactive record.