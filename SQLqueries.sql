-- Create the table schema
CREATE TABLE Loan_Applications (
    Loan_ID VARCHAR(20) PRIMARY KEY,
    Gender VARCHAR(10),
    Married VARCHAR(3),
    Dependents VARCHAR(5),
    Education VARCHAR(20),
    Self_Employed VARCHAR(3),
    ApplicantIncome DECIMAL(10, 2),
    CoapplicantIncome DECIMAL(10, 2),
    LoanAmount DECIMAL(10, 2),
    Loan_Amount_Term INT,
    Credit_History INT,
    Property_Area VARCHAR(20),
    Loan_Status VARCHAR(1)
);

-- Insert the  data
INSERT INTO Loan_Applications (Loan_ID, Gender, Married, Dependents, Education, Self_Employed, ApplicantIncome, CoapplicantIncome, LoanAmount, Loan_Amount_Term, Credit_History, Property_Area, Loan_Status) VALUES
('LP001002', 'Male', 'No', '0', 'Graduate', 'No', 5849.00, 0.00, NULL, 360, 1, 'Urban', 'Y'),
('LP001003', 'Male', 'Yes', '1', 'Graduate', 'No', 4583.00, 1508.00, 128.00, 360, 1, 'Rural', 'N'),
('LP001005', 'Male', 'Yes', '0', 'Graduate', 'Yes', 3000.00, 0.00, 66.00, 360, 1, 'Urban', 'Y'),
('LP001006', 'Male', 'Yes', '0', 'Not Graduate', 'No', 2583.00, 2358.00, 120.00, 360, 1, 'Urban', 'Y'),
('LP001008', 'Male', 'No', '0', 'Graduate', 'No', 6000.00, 0.00, 141.00, 360, 1, 'Urban', 'Y'),
('LP001011', 'Male', 'Yes', '2', 'Graduate', 'Yes', 5417.00, 4196.00, 267.00, 360, 1, 'Urban', 'Y'),
('LP001013', 'Male', 'Yes', '0', 'Not Graduate', 'No', 2333.00, 1516.00, 95.00, 360, 1, 'Urban', 'Y'),
('LP001014', 'Male', 'Yes', '3+', 'Graduate', 'No', 3036.00, 2504.00, 158.00, 360, 0, 'Semiurban', 'N'),
('LP001018', 'Male', 'Yes', '2', 'Graduate', 'No', 4006.00, 1526.00, 168.00, 360, 1, 'Urban', 'Y'),
('LP001020', 'Male', 'Yes', '1', 'Graduate', 'No', 12841.00, 10968.00, 349.00, 360, 1, 'Semiurban', 'N'),
('LP001024', 'Male', 'Yes', '2', 'Graduate', 'No', 3200.00, 700.00, 70.00, 360, 1, 'Urban', 'Y'),
('LP001027', 'Male', 'Yes', '2', 'Graduate', 'No', 2500.00, 1840.00, 109.00, 360, 1, 'Urban', 'Y'),
('LP001028', 'Male', 'Yes', '2', 'Graduate', 'No', 3073.00, 8106.00, 200.00, 360, 1, 'Urban', 'N'),
('LP001029', 'Male', 'No', '0', 'Graduate', 'No', 1853.00, 2840.00, 114.00, 360, 1, 'Rural', 'N'),
('LP001030', 'Male', 'Yes', '2', 'Graduate', 'No', 1299.00, 1086.00, 17.00, 120, 1, 'Urban', 'Y'),
('LP001032', 'Male', 'No', '0', 'Graduate', 'No', 4950.00, 0.00, 125.00, 360, 1, 'Urban', 'Y'),
('LP001034', 'Male', 'No', '1', 'Not Graduate', 'No', 3596.00, 0.00, 100.00, 240, 1, 'Urban', 'Y'),
('LP001036', 'Female', 'No', '0', 'Graduate', 'No', 3510.00, 0.00, 76.00, 360, 0, 'Urban', 'N'),
('LP001038', 'Male', 'Yes', '0', 'Not Graduate', 'No', 4887.00, 0.00, 133.00, 360, 1, 'Rural', 'N'),
('LP001041', 'Male', 'Yes', '0', 'Graduate', 'No', 2600.00, 3500.00, 115.00, 360, 1, 'Urban', 'Y'),
('LP001043', 'Male', 'Yes', '0', 'Not Graduate', 'No', 7660.00, 0.00, 104.00, 360, 0, 'Urban', 'N'),
('LP001046', 'Male', 'Yes', '1', 'Graduate', 'No', 5955.00, 5625.00, 315.00, 360, 1, 'Semiurban', 'Y'),
('LP001047', 'Male', 'Yes', '0', 'Not Graduate', 'No', 2600.00, 1911.00, 116.00, 360, 0, 'Semiurban', 'N'),
('LP001050', 'Male', 'Yes', '2', 'Graduate', 'No', 3365.00, 1917.00, 112.00, 360, 0, 'Rural', 'N'),
('LP001052', 'Male', 'Yes', '1', 'Graduate', 'No', 3717.00, 2925.00, 151.00, 360, 1, 'Semiurban', 'N');

-- Update the LoanAmount for LP001003
UPDATE Loan_Applications
SET LoanAmount = 135.00
WHERE Loan_ID = 'LP001003';

-- Delete the record for LP001036
DELETE FROM Loan_Applications
WHERE Loan_ID = 'LP001036';

-- Select all records to verify changes
SELECT * FROM Loan_Applications;

--Subqueries
-- Applicants with an Income Higher than the Average Income
SELECT
    Loan_ID,
    Gender,
    ApplicantIncome
FROM
    Loan_Applications
WHERE
    ApplicantIncome > (
        SELECT AVG(ApplicantIncome)
        FROM Loan_Applications
    )
ORDER BY
    ApplicantIncome DESC;

-- Applicants Whose Loan Amount is Below the Average for their Property Area
SELECT
    Loan_ID,
    Property_Area,
    LoanAmount
FROM
    Loan_Applications AS outer_app
WHERE
    LoanAmount < (
        SELECT AVG(LoanAmount)
        FROM Loan_Applications AS inner_app
        WHERE inner_app.Property_Area = outer_app.Property_Area
    )
ORDER BY
    Property_Area, LoanAmount DESC;