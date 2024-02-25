# Nashville-Housing
The main objective of this SQL project is for data cleansing using Nashville's properties values between 2013 to 2019

By applying all the code, the result goes from a table with ´NULL´ values, unformated columns and unnecessary information, to a table where it is easier for the user to collect all the information needed, gettind rid of duplicated values, and splitting stacked up columns where not all the information was provided.

To get the desired output, the SQL queries run in the following order

<details>
  <summary>Standarize Date Format</summary>
  
  >Remove Time `00:00:00` from the `Date` column

  | Before | After |
  | ------ | ----- |
  | ![Date Before](https://github.com/Aferha/Nashville-Housing/assets/83234611/315c85a2-6bae-48a5-b139-55f998dbd338) | ![Date After](https://github.com/Aferha/Nashville-Housing/assets/83234611/3300aaff-8a21-4256-bf34-857404c68da6) |

</details>

<details>
  <summary>Populate Property Address Data</summary>

  >Uses the address from `ParcelID` to fill `NULL` values on `PropertyAddress` column

  | Before | After |
  | ------ | ----- |
  | ![Property Address Before](https://github.com/Aferha/Nashville-Housing/assets/83234611/98d539bb-a4a1-46db-aeaa-a7c7518f49b2) | ![Property Address after](https://github.com/Aferha/Nashville-Housing/assets/83234611/01a8c6e5-a83e-4d96-9793-6b7b6f69ba32) |

</details>

<details>
  <summary>Breaking Out Address Into Individual Columns</summary>

  >Splits `PropertyAddress` into two separate columns for address and city

  | Before | After |
  | ------ | ----- |
  | ![Property Address after](https://github.com/Aferha/Nashville-Housing/assets/83234611/cdbc7c01-78ef-459c-acb4-6ba57bc0c6d4) | ![Property Address split after](https://github.com/Aferha/Nashville-Housing/assets/83234611/50746aae-8321-4ea4-9d21-d4bf2e4b98ff) |

</details>

<details>
  <summary>Breaking Out Owner Address Into Individual Columns</summary>

  >Splits `OwnerAddress` into three separate columns for address, city and state
  
  | Before | After |
  | ------ | ----- |
  | ![Owner Address Before](https://github.com/Aferha/Nashville-Housing/assets/83234611/3e5f285e-c8c7-431f-840a-6dccd22809ef) | ![Owner Address After](https://github.com/Aferha/Nashville-Housing/assets/83234611/f72304a8-ff97-4b0e-87ee-3c827d0e0bab) |

</details>

<details>
  <summary>Change Y and N to Yes and No in "Sold as Vacant"</summary>

  >Create a standard `Yes` or `No` coming from multiple answers
  
  | Before | After |
  | ------ | ----- |
  | ![YN Before](https://github.com/Aferha/Nashville-Housing/assets/83234611/8bcbb346-e12f-415a-b4d2-8e9afdd16a9f) | ![YN After](https://github.com/Aferha/Nashville-Housing/assets/83234611/a5c59642-5b3c-4e8c-ab46-23d8eb514aeb) |


</details>

<details>
  <summary>Remove Duplicates</summary>

  >Eliminate duplicated rows based on the compared criteria
</details>

<details>
  <summary>Delete Unused Columns</summary>

  >Although not recommended for DB, in this project the unnecesary information is deleted
</details>

Before:
![All Data Before](https://github.com/Aferha/Nashville-Housing/assets/83234611/401d135a-5004-4671-a0bd-af484eaa5d05)

After:
![All Data After](https://github.com/Aferha/Nashville-Housing/assets/83234611/81f61210-0883-4774-83b3-8be320756a8e)
