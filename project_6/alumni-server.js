let mysql = require('mysql2');
let dbInfo = require('./dbInfo.js');
let express = require('express');
let bodyParser = require("body-parser");
let cors = require('cors');

let app = express();

// Add static route for non-Node.js pages
app.use(express.static('public'));

// Configure body parser for handling post operations
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Get data from table 'authors'
app.get('/authors/:authorID?', function (req, res) {
   console.log("Route /authors GET", req.params);
   let data = [];
   let sql = "SELECT * FROM authors";
   if (req.params.authorID != undefined) {
      sql += " WHERE authorID = ?";
      data = [req.params.authorID];
      // Object technique:
      // sql += " WHERE ?";
      // data = req.params;
      console.log(data);
   } else {
      sql += " ORDER BY lastName";
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

// Get data from view 'alumni_author_articles'
app.get('/vw_alumni_author_articles/:ID?', function (req, res) {
   console.log("Route /vw_alumni_author_articles GET", req.params);
   let data = [];
   let sql = "SELECT * FROM vw_alumni_author_articles";
   if (req.params.ID != undefined) {
      sql += " WHERE ID = ?";
      data = [req.params.ID];
      // Object technique:
      // sql += " WHERE ?";
      // data = req.params;
      console.log(data);
   } else {
      sql += " ORDER BY Author";
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

// Add an author
app.post('/authors', function (req, res) {
   console.log("Route /authors POST");
   let data = {lastName: req.body.lastName, firstName: req.body.firstName};
   connection.query("INSERT INTO authors SET ?",
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

// Delete an author
app.delete('/authors/:authorID?', function (req, res) {
   console.log("Route /authors DELETE");
   let sql = "DELETE FROM authors WHERE authorID = ?";
   // Object technique:
   // let sql = "DELETE FROM authors WHERE ?";
   if (req.params.authorID != undefined) {
      let data = [req.params.authorID];
      // Object technique:
      // let data = {authorID: req.params.authorID};
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
      let s = "Invalid or missing authorID";
      console.log(s);
      res.json({status: "Error", err: s});
   }
});

// Delete an article
app.delete('/sp_delete_article/:p_id?', function (req, res) {
   console.log("Route /sp_delete_article DELETE");
   let sql = "CALL sp_delete_article(?)";
   // Object technique:
   // let sql = "DELETE FROM authors WHERE ?";
   if (req.params.p_id != undefined) {
      let data = [req.params.p_id];
      // Object technique:
      // let data = {authorID: req.params.authorID};
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
      let s = "Invalid or missing p_id";
      console.log(s);
      res.json({status: "Error", err: s});
   }
});

// Update authors
app.put('/authors', function (req, res) {
   console.log("Route /authors PUT");
   let data = [{lastName: req.body.lastName, firstName: req.body.firstName}, req.body.authorID];
   connection.query("UPDATE authors SET ? WHERE authorID = ?",  
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Updated ID: ", req.body.authorID, ", Affected Rows: ", result.affectedRows);
            res.json({status: req.body.authorID, err: "", message: "Row updated"});         }
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
            console.log('Alumni server app listening on port ' + port);
         } catch (err) {
            console.log(err);
         }
      });
   }
});