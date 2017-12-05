#!/usr/bin/env node

const getStdin = require('get-stdin');

const posForChar = {
  '^': (pos) => [pos[0], pos[1] + 1],
  'v': (pos) => [pos[0], pos[1] - 1],
  '>': (pos) => [pos[0] + 1, pos[1]],
  '<': (pos) => [pos[0] - 1, pos[1]]
}

const appendNewPos = (acc, c) => {
  const next = posForChar[c](acc[acc.length - 1])
  return acc.concat([next])
}

getStdin()
  .then(io => io.replace("\n", '').split(''))
  .then(chars => chars.reduce(appendNewPos, [[0,0]]))
  .then(arr => arr.map(xy => `${xy[0]},${xy[1]}`))
  .then(arr => new Set(arr).size)
  .then(console.log)
