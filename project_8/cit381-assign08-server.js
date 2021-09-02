let mysql = require('mysql2');
let dbInfo = require('./dbInfo.js');
let express = require('express');
let bodyParser = require("body-parser");
// let cors = require('cors');

let app = express();

// Add static route for non-Node.js pages
app.use(express.static('public'));

// Configure body parser for handling post operations
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Get data from table 'products'
app.get('/products/:productCode?', function (req, res) {
   console.log("Route /products GET", req.params);
   let data = [];
   let sql = "SELECT * FROM products";
   if (req.params.productCode != undefined) {
      sql += " WHERE productCode = ?";
      data = [req.params.productCode];
      // Object technique:
      // sql += " WHERE ?";
      // data = req.params;
      console.log(data);
   } else {
      sql += " ORDER BY productType";
   }
   console.log("SQL", sql);
   connection.query(sql, data,
      function (errQuery, rows) {
         if (errQuery) {
            console.log(errQuery);
            res.json({rows: [], err: errQuery});
         } else if (rows) {
            console.log("Rows returned", rows.length);
            res.json({rows: rows, err: ""});
         } else {
            console.log("No populated rows...\n");
            res.json({rows: [], err: ""});
         }
      }
   );
});

// Get data from table 'purchases'
app.get('/purchases/:purchaseID?', function (req, res) {
   console.log("Route /purchases GET", req.params);
   let data = [];
   let sql = "SELECT * FROM purchases";
   if (req.params.purchaseID != undefined) {
      sql += " WHERE purchaseID = ?";
      data = [req.params.purchaseID];
      // Object technique:
      // sql += " WHERE ?";
      // data = req.params;
      console.log(data);
   } else {
      sql += " ORDER BY purchaseDate";
   }
   console.log("SQL", sql);
   connection.query(sql, data,
      function (errQuery, rows) {
         if (errQuery) {
            console.log(errQuery);
            res.json({rows: [], err: errQuery});
         } else if (rows) {
            console.log("Rows returned", rows.length);
            res.json({rows: rows, err: ""});
         } else {
            console.log("No populated rows...\n");
            res.json({rows: [], err: ""});
         }
      }
   );
});

// Add a customer
app.post('/customers', function (req, res) {
   console.log("Route /customers POST");
   let data = {customerCode: req.body.customerCode, lastName: req.body.lastName, firstName: req.body.firstName};
   connection.query("INSERT INTO customers SET ?",
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Insert ID: ", result.insertId);
            res.json({status: result.insertId, err: ""});
         }
      }
   );
});

// Delete a customer
app.delete('/customers/:customerCode?', function (req, res) {
   console.log("Route /customers DELETE");
   let sql = "DELETE FROM customers WHERE customerCode = ?";
   // Object technique:
   // let sql = "DELETE FROM customers WHERE ?";
   if (req.params.customerCode != undefined) {
      let data = [req.params.customerCode];
      // Object technique:
      // let data = {customerCode: req.params.customerCode};
      connection.query(sql, 
         data, 
         function (errQuery, result) {
            if (errQuery) {
               console.log(errQuery);
               res.json({status: "Error", err: errQuery});
            } else {
               console.log("Deleted");
               res.json({status: "Deleted", err: ""});
            }
         }
      );
   } else {
      let s = "Invalid or missing customerCode";
      console.log(s);
      res.json({status: "Error", err: s});
   }
});

// Update customers
app.put('/customers', function (req, res) {
   console.log("Route /customers PUT");
   let data = [{lastName: req.body.lastName, firstName: req.body.firstName}, req.body.customerCode];
   connection.query("UPDATE customers SET ? WHERE customerCode = ?",  
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Updated ID: ", req.body.customerCode, ", Affected Rows: ", result.affectedRows);
            res.json({status: req.body.customerCode, err: "", message: "Row updated"});         }
      }
   );
});

// Handle missing pages requested using GET HTTP verb
app.get('*', function(req, res) {
   res.status(404).send('Sorry that page does not exist');
});

// Create database connection
console.log('Creating connection...\n');
let connection = mysql.createConnection({
   host: dbInfo.dbHost,
   port: dbInfo.dbPort,
   user: dbInfo.dbUser,
   password: dbInfo.dbPassword,
   database: dbInfo.dbDatabase
});
// Connect to database
connection.connect(function(err) {
   console.log('Connecting to database...\n');

   // Handle any errors
   if (err) {
      console.log(err);
      console.log('Exiting application...\n');
   } else {
      console.log('Connected to database...\n');
      // Listen for connections
      // Note: Will terminate with an error if database connection
      // is closed
      const ip = 'localhost';
      const port = 8080;
      app.listen(port, ip, function () {
         try {
            console.log('Supermarket server app listening on port ' + port);
         } catch (err) {
            console.log(err);
         }
      });
   }
});