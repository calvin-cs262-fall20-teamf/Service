const pgp = require('pg-promise')();
const db = pgp({
    host: process.env.SERVER,
    port: 5432,
    database: process.env.USER,
    user: process.env.USER,
    password: process.env.PASSWORD
});

// Reference from https://stackoverflow.com/questions/11001817/allow-cors-rest-request-to-a-express-node-js-application-on-heroku
var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

    // intercept OPTIONS method
    if ('OPTIONS' == req.method) {
      res.send(200);
    }
    else {
      next();
    }
};

// Configure the server and its routes.
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

// URLs
router.get("/", readHelloMessage);
router.get("/locations", readLocations);
router.get("/locations/:id", readLocation);
router.get("/statusreports", readCurrentStatus);
router.get("/statusreports/:id", readCurrentStatusid);
router.get("/currentpopulations", readCurrentPopulations);
router.get("/currentpopulations/:id", readCurrentPopulation);
router.get("/locationstatus", readLocationStatuses);

// POST
router.post('/currentstatus', createReport);

app.use(allowCrossDomain);
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

function readLocations(req, res, next) {
    db.many("SELECT * FROM Location")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readLocation(req, res, next) {
    db.oneOrNone("SELECT * FROM Location WHERE ID=${req.params.id}")
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function readCurrentStatus(req, res, next) {
    db.many("SELECT * FROM StatusReport")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readCurrentStatusid(req, res, next) {
    db.oneOrNone(`SELECT * FROM StatusReport WHERE ID=${req.params.id}`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function readCurrentPopulations(req, res, next) {
    db.many("SELECT * FROM CurrentPopulation")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readCurrentPopulation(req, res, next) {
    db.oneOrNone('SELECT * FROM CurrentPopulation WHERE ID=${id}', req.params)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}


function readLocationStatuses(req, res, next) {
    db.many("SELECT LocationID, AVG(status) FROM StatusReport GROUP BY LocationID ORDER BY LocationID")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}


// POST methods
function createReport(req, res, next) {
    db.one('INSERT INTO StatusReport(status, locationID, reportedTime) VALUES (${status}, ${locationid}, NOW())', req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}
