use new_db;

UPDATE Salary S, Employee E
SET S.pay_date = E.since
WHERE S.pay_ID = E.pay_ID AND S.pay_date = NULL;


INSERT INTO Arrears (arrears_ID, a_pdate, a_date, a_status, pay_ID) VALUES ('AR001', TO_DATE('2023-04-15', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'PENDING', 20000, 'PAY001');
INSERT INTO Arrears (arrears_ID, a_pdate, a_date, a_status, pay_ID) VALUES ('AR002', TO_DATE('2023-04-30', 'YYYY-MM-DD'), TO_DATE('2022-12-01', 'YYYY-MM-DD'), 'PAID', 10000, 'PAY002');

INSERT INTO Employee (employee_ID, email, first_name, last_name, phone_number, gender, since, d_ID, p_ID, salary_ID, pay_ID)
VALUES ('E001', 'john.doe@company.com', 'John', 'Doe', '1234567890', 'Male', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'D01', 'P01', 'S001', 'PAY001');
INSERT INTO Employee (employee_ID, email, first_name, last_name, phone_number, gender, since, d_ID, p_ID, salary_ID, pay_ID)
VALUES ('E002', 'jane.smith@company.com', 'Jane', 'Smith', '0987654321', 'Female', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'D02', 'P02', 'S002', 'PAY002');

INSERT INTO Salary (s_ID, pay_date, pay_ID) VALUES ('S001', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'PAY001');
INSERT INTO Salary (s_ID, pay_date, pay_ID) VALUES ('S002', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 'PAY002');

INSERT INTO Leaves (leave_ID, leave_begin, leave_end, employee_ID) VALUES ('L001', '2023-03-18', '2023-03-22', 'E001');
INSERT INTO Leaves (leave_ID, leave_begin, leave_end, employee_ID) VALUES ('L002', '2023-04-05', '2023-04-07', 'E002');

SELECT * FROM Leaves;

INSERT INTO Post (p_ID, p_name, p_pay) VALUES ('P01', 'Manager', 10000);
INSERT INTO Post (p_ID, p_name, p_pay) VALUES ('P02', 'Engineer', 45000);

INSERT INTO Department (d_ID, d_name, head, d_pay) VALUES ('D01', 'Engineering', 'John Doe', 50000);	
INSERT INTO Department (d_ID, d_name, head, d_pay) VALUES ('D02', 'Sales', 'Jane Smith', 48000);

INSERT INTO Payment (pay_ID) VALUES ('PAY001');
INSERT INTO Payment (pay_ID) VALUES ('PAY002');

INSERT INTO Bonus (b_ID, amount, reason, pay_ID) VALUES ('B001', 5000, 'Year-end bonus', 'PAY001');
INSERT INTO Bonus (b_ID, amount, reason, pay_ID) VALUES ('B002', 2000, 'Performance bonus', 'PAY002');

INSERT INTO Allow (allow_ID, med_allows, HRA, DA, pay_ID) VALUES ('A001', 3000, 4000, 2000, 'PAY001');
INSERT INTO Allow (allow_ID, med_allows, HRA, DA, pay_ID) VALUES ('A002', 2000, 3500, 1500, 'PAY002');


INSERT INTO Deducts (deduct_ID, hotel_chrg, security_chrg, welfare_fund, pay_ID) VALUES ('D001', 2000, 1000, 500, 'PAY001');
INSERT INTO Deducts (deduct_ID, hotel_chrg, security_chrg, welfare_fund, pay_ID) VALUES ('D002', 1500, 500, 300, 'PAY002');

INSERT INTO tax_base (tax_ID, pay_ID) VALUES ('TAX001', 'PAY001');
INSERT INTO tax_base (tax_ID, pay_ID) VALUES ('TAX002', 'PAY002');

INSERT INTO Depend_deduct (tax_ID, Depend_rela, Depend_amount, Depend_ID, pay_ID) VALUES ('TAX001', 'Spouse', 2000, 'D001', 'PAY001');
INSERT INTO Depend_deduct (tax_ID, Depend_rela, Depend_amount, Depend_ID, pay_ID) VALUES ('TAX001', 'Child', 1500, 'D002', 'PAY001');
INSERT INTO Depend_deduct (tax_ID, Depend_rela, Depend_amount, Depend_ID, pay_ID) VALUES ('TAX002', 'Spouse', 1800, 'D003', 'PAY002');
INSERT INTO Depend_deduct (tax_ID, Depend_rela, Depend_amount, Depend_ID, pay_ID) VALUES ('TAX002', 'Child', 1200, 'D004', 'PAY002');


UPDATE Payment P
SET P.amount = 
    (SELECT * FROM 
        (SELECT 
            S.basic_pay * (1 + S.total_raise) * (DATEDIFF(S.pay_date, CURRENT_DATE()) - COALESCE(L.duration, 0) - 8)
            - S.basic_pay * T.amount / 100
            + COALESCE((SELECT SUM(B.amount) FROM Bonus B WHERE S.pay_id = B.pay_id), 0)
            + COALESCE((SELECT SUM(A.med_allows) FROM Allow A WHERE S.pay_id = A.pay_id), 0)
            + COALESCE((SELECT SUM(A.HRA) FROM Allow A WHERE S.pay_id = A.pay_id), 0)
            + COALESCE((SELECT SUM(A.DA) FROM Allow A WHERE S.pay_id = A.pay_id), 0)
            + COALESCE((SELECT SUM(Arr.amount) FROM Arrears Arr WHERE S.pay_id = Arr.pay_id), 0)
            - COALESCE((SELECT SUM(D.hotel_chrg) FROM Deducts D WHERE S.pay_id = D.pay_id), 0)
            - COALESCE((SELECT SUM(D.security_chrg) FROM Deducts D WHERE S.pay_id = D.pay_id), 0)
            - COALESCE((SELECT SUM(D.welfare_fund) FROM Deducts D WHERE S.pay_id = D.pay_id), 0)
            + COALESCE(T.amount * Dd.Depend_amount, 0)
        FROM 
            Salary S 
            JOIN Employee E ON S.s_id = E.salary_id 
            JOIN Payment P2 ON S.pay_id = P2.pay_id
            LEFT JOIN Leaves L ON E.employee_id = L.employee_id
            LEFT JOIN Depend_deduct Dd ON P2.pay_id = Dd.pay_id
            LEFT JOIN tax_base T ON T.pay_id = P2.pay_id
        WHERE 
            P.pay_id = P2.pay_id) AS temp_table
	) 
WHERE 
    EXISTS (SELECT 1 FROM Salary S WHERE P.pay_id = S.pay_id);









