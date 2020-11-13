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
// router.get("/curentpopulation", readCurrentPopulation);
// router.get("/users", readUsers);

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

// function readCurrentPopulation(req, res, next) {
//     console.log("s")
//     db.many("SELECT * FROM currentpopulation")
//         .then(data => {
//             res.send(data);
//         })
//         .catch(err => {
//             next(err);
//         })
// }

// function readCurrentPopulation(req, res, next) {
//     db.many("SELECT * FROM users")
//         .then(data => {
//             res.send(data);
//         })
//         .catch(err => {
//             next(err);
//         })
// }