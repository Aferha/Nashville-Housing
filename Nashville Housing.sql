/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM Housing.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format

SELECT SaleDate, CONVERT(date, SaleDate)
FROM Housing.dbo.NashvilleHousing

UPDATE Housing..NashvilleHousing
SET SaleDate = CONVERT(date, SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

UPDATE Housing..NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

--------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data

SELECT *
FROM Housing.dbo.NashvilleHousing
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Housing.dbo.NashvilleHousing a
JOIN Housing.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Housing.dbo.NashvilleHousing a
JOIN Housing.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

--------------------------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City)

SELECT *
FROM Housing.dbo.NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM Housing.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE Housing..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE Housing..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

--------------------------------------------------------------------------------------------------------------------------
-- Breaking out Owner Address into Individual Columns (Address, City, State)

SELECT OwnerAddress
FROM Housing.dbo.NashvilleHousing

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Adress
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM Housing.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);

ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(255);

UPDATE Housing..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

UPDATE Housing..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE Housing..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM Housing.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM Housing..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) AS row_num
FROM Housing..NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1

---------------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT *
FROM Housing.dbo.NashvilleHousing

ALTER TABLE Housing.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------