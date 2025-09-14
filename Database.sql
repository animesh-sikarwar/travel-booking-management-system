
CREATE DATABASE IF NOT EXISTS travel;
USE travel;



CREATE TABLE IF NOT EXISTS CustomerDetails (
    CustomerID      INT PRIMARY KEY,
    FullName        VARCHAR(50)   NOT NULL,
    Email           VARCHAR(100)  NOT NULL,
    Phone           VARCHAR(10)   NOT NULL,
    Identity_proof  VARCHAR(100)  NOT NULL,
    CONSTRAINT CK_email_format CHECK (Email LIKE '%@gmail.com'),
    CONSTRAINT CK_phone_digits CHECK (Phone REGEXP '^[0-9]{10}$')
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID   INT PRIMARY KEY,
    Emp_name     VARCHAR(50)  NOT NULL,
    Department   VARCHAR(50)  NOT NULL,
    Emp_salary   INT          NOT NULL,
    Emp_Position VARCHAR(50)  NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Destination (
    DestinationID   INT PRIMARY KEY,
    DestinationName VARCHAR(50) NOT NULL,
    Distance        INT         NOT NULL,
    Country         VARCHAR(50) NOT NULL
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS Trains (
    TrainID          INT PRIMARY KEY,
    TrainName        VARCHAR(50)  NOT NULL,
    T_DepartureTime  TIME         NOT NULL,
    T_ArrivalTime    TIME         NOT NULL,
    T_Origin         VARCHAR(50)  NOT NULL,
    T_Destination    VARCHAR(50)  NOT NULL,
    DestinationID    INT          NOT NULL,
    CONSTRAINT FK_trains_dest FOREIGN KEY (DestinationID)
        REFERENCES Destination(DestinationID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Flights (
    FlightID         INT PRIMARY KEY,
    FlightNumber     VARCHAR(10)  NOT NULL,
    Airline          VARCHAR(50)  NOT NULL,
    FL_DepartureTime DATETIME     NOT NULL,
    FL_ArrivalTime   DATETIME     NOT NULL,
    FL_Origin        VARCHAR(50)  NOT NULL,
    FL_Destination   VARCHAR(50)  NOT NULL,
    DestinationID    INT          NOT NULL,
    CONSTRAINT UQ_flight_number UNIQUE (FlightNumber),
    CONSTRAINT FK_flights_dest FOREIGN KEY (DestinationID)
        REFERENCES Destination(DestinationID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Buses (
    BusID            INT PRIMARY KEY,
    BusNumber        VARCHAR(10)  NOT NULL,
    Operator         VARCHAR(50)  NOT NULL,
    B_DepartureTime  DATETIME     NOT NULL,
    B_ArrivalTime    DATETIME     NOT NULL,
    B_Origin         VARCHAR(50)  NOT NULL,
    B_Destination    VARCHAR(50)  NOT NULL,
    DestinationID    INT          NOT NULL,
    CONSTRAINT UQ_bus_number UNIQUE (BusNumber),
    CONSTRAINT FK_buses_dest FOREIGN KEY (DestinationID)
        REFERENCES Destination(DestinationID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Cruise (
    CruiseID         INT PRIMARY KEY,
    CruiseName       VARCHAR(50)  NOT NULL,
    CR_DepartureTime DATETIME     NOT NULL,
    CR_ArrivalTime   DATETIME     NOT NULL,
    CR_Origin        VARCHAR(50)  NOT NULL,
    CR_Destination   VARCHAR(50)  NOT NULL,
    DestinationID    INT          NOT NULL,
    CONSTRAINT FK_cruise_dest FOREIGN KEY (DestinationID)
        REFERENCES Destination(DestinationID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Car (
    CarID         INT PRIMARY KEY,
    CarModel      VARCHAR(50) NOT NULL,
    PlateNumber   VARCHAR(20) NOT NULL,
    Capacity      INT         NOT NULL,
    C_Origin      VARCHAR(50) NOT NULL,
    C_Destination VARCHAR(50) NOT NULL,
    DestinationID INT         NOT NULL,
    CONSTRAINT UQ_car_plate UNIQUE (PlateNumber),
    CONSTRAINT FK_car_dest FOREIGN KEY (DestinationID)
        REFERENCES Destination(DestinationID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS Payment (
    PaymentID     INT PRIMARY KEY,
    PaymentMethod VARCHAR(50)   NOT NULL,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate   DATE          NOT NULL,
    CustomerID    INT           NOT NULL,
    CONSTRAINT CK_payment_method CHECK (PaymentMethod IN ('Credit Card','Debit Card','Net Banking','UPI','Cash')),
    CONSTRAINT FK_payment_customer FOREIGN KEY (CustomerID)
        REFERENCES CustomerDetails(CustomerID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Booking (
    BookingID      INT PRIMARY KEY,
    CustomerID     INT           NOT NULL,
    Booking_status VARCHAR(20)   NOT NULL DEFAULT 'Pending',
    PaymentID      INT           NOT NULL,
    Booking_time   DATETIME      NOT NULL,
    Transport      VARCHAR(50)   NOT NULL,
    Origin         VARCHAR(50)   NOT NULL,
    Destination    VARCHAR(50)   NOT NULL,
    CONSTRAINT CK_booking_status CHECK (Booking_status IN ('Pending','Confirmed','Cancelled')),
    CONSTRAINT FK_booking_customer FOREIGN KEY (CustomerID)
        REFERENCES CustomerDetails(CustomerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_booking_payment FOREIGN KEY (PaymentID)
        REFERENCES Payment(PaymentID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;



INSERT INTO CustomerDetails (CustomerID, FullName, Email, Phone, Identity_proof) VALUES
    (1,'Amishi Desai','desai014@gmail.com','9345698768','Aadhar'),
    (2,'Chahel Gupta','chx2904@gmail.com','9876543210','Passport'),
    (3,'Aneri Patel','ap2404@gmail.com','7890123456','Driver License'),
    (4,'Demira Ramnani','demram23@gmail.com','2345678901','Aadhar'),
    (5,'Shloka Arya','shloksrain@gmail.com','8901234567','Passport'),
    (6,'Vansh Mehta','vm567@gmail.com','3456789012','Driver License'),
    (7,'Shital Nagvenkar','shtlnad@gmail.com','9012345678','Aadhar'),
    (8,'Vikram Nadkarni','viks01@gmail.com','4567890123','Passport'),
    (9,'Aryan Shah','arshah56@gmail.com','0123456789','Driver License'),
    (10,'Veer Patil','vp3til@gmail.com','9398631146','Aadhar');

INSERT INTO Employee (EmployeeID, Emp_name, Department, Emp_salary, Emp_Position) VALUES
    (1,'Vivean Arya','Bus',54000,'Driver'),
    (2,'Sonia Mascerehnas','Car',55000,'Guide'),
    (3,'Vansh Dhoka','Train',60000,'Supervisor'),
    (4,'Pratham Vasa','Flight',65000,'Booking Agent'),
    (5,'Amit Singh','Cruise',70000,'Guide'),
    (6,'Sunita Reddy','Bus',50000,'Driver'),
    (7,'Rahul Verma','Car',60000,'Supervisor'),
    (8,'Vivek Mishra','Flight',70000,'Guide'),
    (9,'Anjali Shah','Train',65000,'Booking Agent'),
    (10,'Pooja Gupta','Cruise',75000,'Supervisor');

INSERT INTO Destination (DestinationID, DestinationName, Distance, Country) VALUES
    (201,'Mumbai',0,'India'),
    (202,'Pune',200,'India'),
    (203,'Chennai',439,'India'),
    (204,'Bangalore',5674,'India'),
    (205,'Hyderabad',7656,'India'),
    (206,'Delhi',987,'India'),
    (207,'Kolkata',0,'India'),
    (301,'London',12768,'United Kingdom'),
    (302,'Singapore',5567,'Singapore'),
    (303,'Dubai',767,'United Arab Emirates'),
    (304,'Frankfurt',7898,'Germany'),
    (305,'Sydney',9783,'Australia'),
    (101,'Ahmedabad',0,'India'),
    (102,'Jaipur',838,'India'),
    (103,'Indore',595,'India'),
    (104,'Lucknow',895,'India');



INSERT INTO Trains (TrainID, TrainName, T_DepartureTime, T_ArrivalTime, T_Origin, T_Destination, DestinationID) VALUES
    (1,'Rajdhani Express','08:00:00','15:00:00','Delhi','Mumbai',201),
    (2,'Shatabdi Express','09:00:00','14:00:00','Mumbai','Pune',202),
    (3,'Duronto Express','10:00:00','17:00:00','Delhi','Chennai',203),
    (4,'Garib Rath Express','11:00:00','18:00:00','Kolkata','Bangalore',204),
    (5,'Shatabdi Express','12:00:00','19:00:00','Chennai','Hyderabad',205),
    (6,'Rajdhani Express','13:00:00','20:00:00','Bangalore','Delhi',206),
    (7,'Duronto Express','14:00:00','21:00:00','Mumbai','Kolkata',207),
    (8,'Garib Rath Express','15:00:00','22:00:00','Pune','Chennai',203),
    (9,'Shatabdi Express','16:00:00','23:00:00','Delhi','Hyderabad',205),
    (10,'Rajdhani Express','17:00:00','00:00:00','Kolkata','Mumbai',201);

INSERT INTO Flights (FlightID, FlightNumber, Airline, FL_DepartureTime, FL_ArrivalTime, FL_Origin, FL_Destination, DestinationID) VALUES
    (1,'AI101','Air India','2024-03-18 08:00:00','2024-03-18 10:00:00','Delhi','Mumbai',201),
    (2,'AI102','Air India','2024-03-18 10:00:00','2024-03-18 12:00:00','Mumbai','Pune',202),
    (3,'AI103','Air India','2024-03-18 12:00:00','2024-03-18 15:00:00','Delhi','Chennai',203),
    (4,'AI104','Air India','2024-03-18 14:00:00','2024-03-18 17:00:00','Mumbai','Bangalore',204),
    (5,'BA101','British Airways','2024-03-18 16:00:00','2024-03-18 18:00:00','Delhi','London',301),
    (6,'SQ101','Singapore Airlines','2024-03-18 18:00:00','2024-03-18 20:00:00','Mumbai','Singapore',302),
    (7,'EK101','Emirates','2024-03-18 20:00:00','2024-03-19 02:00:00','Delhi','Dubai',303),
    (8,'LH101','Lufthansa','2024-03-18 22:00:00','2024-03-19 01:00:00','Mumbai','Frankfurt',304),
    (9,'QF101','Qantas','2024-03-19 01:00:00','2024-03-19 06:00:00','Delhi','Sydney',305),
    (10,'SQ104','Singapore Airlines','2024-03-19 03:00:00','2024-03-19 05:00:00','Mumbai','Singapore',302);

INSERT INTO Buses (BusID, BusNumber, Operator, B_DepartureTime, B_ArrivalTime, B_Origin, B_Destination, DestinationID) VALUES
    (1,'B001','ABC Bus Services','2024-03-18 08:00:00','2024-03-18 10:00:00','Delhi','Mumbai',201),
    (2,'B002','XYZ Travels','2024-03-18 10:00:00','2024-03-18 12:00:00','Mumbai','Pune',202),
    (3,'B003','RST Tours','2024-03-18 12:00:00','2024-03-18 15:00:00','Delhi','Chennai',203),
    (4,'B004','PQR Roadways','2024-03-18 14:00:00','2024-03-18 17:00:00','Mumbai','Bangalore',204),
    (5,'B005','LMN Travels','2024-03-18 16:00:00','2024-03-18 18:00:00','Delhi','Hyderabad',205),
    (6,'B006','DEF Bus Lines','2024-03-18 18:00:00','2024-03-18 20:00:00','Mumbai','Kolkata',207), -- fixed: 207 for Kolkata
    (7,'B007','GHI Tours','2024-03-18 20:00:00','2024-03-19 02:00:00','Delhi','Lucknow',104),
    (8,'B008','JKL Bus Services','2024-03-18 22:00:00','2024-03-19 01:00:00','Mumbai','Ahmedabad',101),
    (9,'B009','MNO Roadways','2024-03-19 01:00:00','2024-03-19 06:00:00','Delhi','Jaipur',102),
    (10,'B010','PQR Travels','2024-03-19 03:00:00','2024-03-19 05:00:00','Mumbai','Indore',103);

INSERT INTO Cruise (CruiseID, CruiseName, CR_DepartureTime, CR_ArrivalTime, CR_Origin, CR_Destination, DestinationID) VALUES
    (1,'London to Sydney Cruise','2024-03-18 08:00:00','2024-03-18 20:00:00','London','Sydney',305),
    (2,'Singapore to Dubai Cruise','2024-03-18 10:00:00','2024-03-18 22:00:00','Singapore','Dubai',303),
    (3,'Frankfurt to Sydney Cruise','2024-03-18 12:00:00','2024-03-18 23:00:00','Frankfurt','Sydney',305),
    (4,'Dubai to London Cruise','2024-03-18 14:00:00','2024-03-18 23:00:00','Dubai','London',301),
    (5,'Sydney to Singapore Cruise','2024-03-18 16:00:00','2024-03-19 01:00:00','Sydney','Singapore',302),
    (6,'London to Dubai Cruise','2024-03-18 18:00:00','2024-03-19 04:00:00','London','Dubai',303),
    (7,'Singapore to Sydney Cruise','2024-03-18 20:00:00','2024-03-19 08:00:00','Singapore','Sydney',305),
    (8,'Frankfurt to Dubai Cruise','2024-03-18 22:00:00','2024-03-19 10:00:00','Frankfurt','Dubai',303),
    (9,'Dubai to Singapore Cruise','2024-03-19 01:00:00','2024-03-19 10:00:00','Dubai','Singapore',302),
    (10,'Sydney to London Cruise','2024-03-19 03:00:00','2024-03-19 16:00:00','Sydney','London',301);

INSERT INTO Car (CarID, CarModel, PlateNumber, Capacity, C_Origin, C_Destination, DestinationID) VALUES
    (101,'Toyota Innova','MH01AB1234',7,'Mumbai','Pune',202),
    (102,'Maruti Swift','MH02CD5678',5,'Pune','Mumbai',201),
    (103,'Honda City','MH03EF9012',5,'Chennai','Bangalore',204),
    (104,'Hyundai i20','MH04GH3456',5,'Bangalore','Hyderabad',205),
    (105,'Ford EcoSport','MH05IJ6789',5,'Hyderabad','Chennai',203),
    (106,'Volkswagen Polo','MH06KL0123',5,'Delhi','Kolkata',207),
    (107,'Toyota Corolla','MH07MN3456',5,'Kolkata','Delhi',206),
    (108,'Renault Kwid','MH08OP6789',5,'Ahmedabad','Jaipur',102),
    (109,'Honda Civic','MH09QR0123',5,'Jaipur','Indore',103),
    (110,'Mahindra Scorpio','MH10ST3456',7,'Indore','Ahmedabad',101);



INSERT INTO Payment (PaymentID, PaymentMethod, PaymentAmount, PaymentDate, CustomerID) VALUES
    (101,'Credit Card',5000.00,'2023-01-15',1),
    (102,'Debit Card',3000.00,'2023-02-20',2),
    (103,'Net Banking',2000.00,'2023-03-25',3),
    (104,'UPI',4000.00,'2023-04-30',4),
    (105,'Cash',2500.00,'2023-05-05',5),
    (106,'Credit Card',3500.00,'2023-06-10',6),
    (107,'Debit Card',2800.00,'2023-07-15',7),
    (108,'Net Banking',1800.00,'2023-08-20',8),
    (109,'UPI',4200.00,'2023-09-25',9),
    (110,'Cash',2300.00,'2023-10-30',10);



INSERT INTO Booking
    (BookingID, CustomerID, Booking_status, PaymentID, Booking_time, Transport, Origin, Destination)
VALUES
    (1, 1, 'Confirmed', 101, '2024-03-10 08:00:00',
        (SELECT Operator     FROM Buses   WHERE DestinationID=201 ORDER BY BusID   LIMIT 1), 'Delhi','Mumbai'),
    (2, 2, 'Confirmed', 102, '2024-03-10 10:00:00',
        (SELECT PlateNumber  FROM Car     WHERE DestinationID=202 ORDER BY CarID   LIMIT 1), 'Mumbai','Pune'),
    (3, 3, 'Confirmed', 103, '2024-03-10 12:00:00',
        (SELECT FlightNumber FROM Flights WHERE DestinationID=203 ORDER BY FlightID LIMIT 1), 'Delhi','Chennai'),
    (4, 4, 'Confirmed', 104, '2024-03-10 14:00:00',
        (SELECT FlightNumber FROM Flights WHERE DestinationID=204 ORDER BY FlightID LIMIT 1), 'Mumbai','Bangalore'),
    (5, 5, 'Confirmed', 105, '2024-03-10 16:00:00',
        (SELECT CruiseName   FROM Cruise  WHERE DestinationID=303 AND CR_Origin='Singapore' ORDER BY CruiseID LIMIT 1), 'Singapore','Dubai'),
    (6, 6, 'Confirmed', 106, '2024-03-10 18:00:00',
        (SELECT Operator     FROM Buses   WHERE DestinationID=207 ORDER BY BusID   LIMIT 1), 'Mumbai','Kolkata'), -- fixed: 207
    (7, 7, 'Confirmed', 107, '2024-03-10 20:00:00',
        (SELECT PlateNumber  FROM Car     WHERE DestinationID=103 ORDER BY CarID   LIMIT 1), 'Jaipur','Indore'),
    (8, 8, 'Confirmed', 108, '2024-03-10 22:00:00',
        (SELECT TrainName    FROM Trains  WHERE DestinationID=204 ORDER BY TrainID LIMIT 1), 'Kolkata','Bangalore'),
    (9, 9, 'Confirmed', 109, '2024-03-11 01:00:00',
        (SELECT FlightNumber FROM Flights WHERE DestinationID=203 ORDER BY FlightID LIMIT 1), 'Delhi','Chennai'),
    (10,10,'Confirmed', 110, '2024-03-11 03:00:00',
        (SELECT CruiseName   FROM Cruise  WHERE DestinationID=301 AND CR_Origin='Sydney' ORDER BY CruiseID LIMIT 1), 'Sydney','London');



CREATE INDEX idx_trains_dest     ON Trains(DestinationID);
CREATE INDEX idx_flights_dest    ON Flights(DestinationID);
CREATE INDEX idx_buses_dest      ON Buses(DestinationID);
CREATE INDEX idx_cruise_dest     ON Cruise(DestinationID);
CREATE INDEX idx_car_dest        ON Car(DestinationID);
CREATE INDEX idx_payment_cust    ON Payment(CustomerID);
CREATE INDEX idx_booking_cust    ON Booking(CustomerID);
CREATE INDEX idx_booking_payment ON Booking(PaymentID);
