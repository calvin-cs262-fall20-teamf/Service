/**
 * This module implements a REST-inspired webservice for the Freespace database.
 * The database is hosted on ElephantSQL.
 *
 * To guard against SQL injection attacks, this code uses pg-promise's built-in
 * variable escaping. This prevents a client from issuing this URL:
 *     https://calvinfreespace.herokuapp.com/locations/1%3BDELETE%20FROM%20Location%3BDELETE%20FROM%20StatusReport
 * which would delete records in the PlayerGame and then the Player tables.
 * In particular, we don't use JS template strings because it doesn't filter
 * client-supplied values properly.
 *
 * @date: Fall, 2020
 */

// Set up the database connection.
const pgp = require('pg-promise')();
const db = pgp({
    host: process.env.HOST,
    port: process.env.DB_PORT, //5432
    database: process.env.USER,
    user: process.env.USER,
    password: process.env.PASSWORD
});

// Configure the server and its routes.
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

// URLs for GET
router.get("/", readHelloMessage);
router.get("/locations", readLocations);
router.get("/locations/:id", readLocation);
router.get("/statusreports", readCurrentStatus);
router.get("/statusreports/:id", readCurrentStatusid);
router.get("/locationstatus", readLocationStatuses);

// URL for POST
router.post('/statusreports', createReport);

// URL for PUT
router.put('/statusreports/:id', updateReport);

// URL for DELETE
router.delete('/statusreports/:id', deleteReport)

app.use(router);
app.use(errorHandler);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.
function errorHandler(err, req, res) {
    if (app.get('env') === "development") {
        console.log(err);
    }
    res.sendStatus(err.status || 500);
}

function returnDataOr404(res, data) {
    if (data == null) {
        res.sendStatus(404);
    } else {
        res.send(data);
    }
}

function readHelloMessage(req, res) {
    res.send('Welcome to Freespace Database!');
}

/********************
  Read functions
 ********************/

// Gets all records in Location table
function readLocations(req, res, next) {
    db.many("SELECT * FROM Location")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

// Gets record in Location table with specified ID
function readLocation(req, res, next) {
    db.oneOrNone(`SELECT * FROM Location WHERE ID=${req.params.id}`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

// Gets all records from StatusReport table
function readCurrentStatus(req, res, next) {
    db.many("SELECT * FROM StatusReport")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

// Gets record in StatusReport table with specified ID
function readCurrentStatusid(req, res, next) {
    db.oneOrNone(`SELECT * FROM StatusReport WHERE ID=${req.params.id}`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

// Joins the StatusReport and Location tables and returns a table specifying the average status for each location
//  Ordered by the locations' ID numbers.
//  Only takes the reports that have been submitted within the last two hours along with the
//  basis zero-value reports (used for averaging).
function readLocationStatuses(req, res, next) {
    db.many("SELECT LocationID as key, LocationID, name, maxCapacity, \
             AVG(status) as statusAverage, COUNT(*) as numReports FROM \
                (\
                    SELECT *\
                    FROM StatusReport \
                    WHERE reportedTime >= NOW() - INTERVAL '2 hours' \
                    OR date(reportedTime) = '2020-1-20' \
                ) AS FilterQuery, Location \
                WHERE LocationID = Location.ID \
                GROUP BY name, LocationID, maxCapacity \
                ORDER BY LocationID \
            ;")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}


/********************
  Create functions
 ********************/

// Creates a new record in the StatusReport table.
//  Record is created with the given status and locationID.
//  reportedTime is generated automatically and is set to the time when the report was submitted.
function createReport(req, res, next) {
    db.one('INSERT INTO StatusReport(status, locationID, reportedTime) VALUES (${status}, ${locationid}, NOW())', req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}

/********************
  Update functions
 ********************/

// Updates an existing record with the specified ID in the StatusReport table.
//  Record is updated with the given status and locationID.
//  reportedTime is updated automatically and is set to the time when the report was updated.
function updateReport(req, res, next) {
    db.oneOrNone('UPDATE StatusReport SET status=${body.status}, locationID={body.locationid}, reportedTime=NOW() WHERE id=${params.id} RETURNING id', req)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

/********************
  Delete functions
 ********************/

// Deletes an existing report with the specified ID in the StatusReport table.
function deleteReport(req, res, next) {
    db.oneOrNone('DELETE FROM StatusReport WHERE id=${id} RETURNING id', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
