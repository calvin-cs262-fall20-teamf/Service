const pgp = require('pg-promise')();
const db = pgp({
    host: process.env.DB_SERVER,
    port: 5432,
    database: process.env.DB_USER,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});


// Configure the server and its routes.

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

router.get("/", readHelloMessage);
router.get("/locations", readLocations);
router.get("/location/:id", readLocation);
router.get("/currentStatus", readCurrentStatus)
// router.put("/players/:id", updatePlayer);
// router.post('/players', createPlayer);
// router.delete('/players/:id', deletePlayer);

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
    res.send('Hello, CS 262 Monopoly service!');
}

function readLocations(req, res, next) {
    db.many("SELECT * FROM Locations")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readLocation(req, res, next) {
    db.oneOrNone(`SELECT * FROM Locations WHERE id=${req.params.id}`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function readCurrentStatus(req, res, next) {
    db.many("SELECT * FROM CurrentStatus")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
