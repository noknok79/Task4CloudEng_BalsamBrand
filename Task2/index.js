

const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Hello Mark Anthony Villanueva"/n "Welcome to Balsam Brands'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
