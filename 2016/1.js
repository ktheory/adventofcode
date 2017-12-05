#!/usr/bin/env node

const getStdin = require('get-stdin');

// 0 = north
// 1 = east
// 2 = south
// 3 = west
//
// R => +1
// L => -1

const initPos = { dir: 0, pos: [0,0] };

const adjustPos = [
  (pos, dist) => [pos[0], pos[1] + dist],
  (pos, dist) => [pos[0] + dist, pos[1]],
  (pos, dist) => [pos[0], pos[1] - dist],
  (pos, dist) => [pos[0] - dist, pos[1]]
]

const adjustDir = {
  'R': (dir) => (dir + 1) % 4,
  'L': (dir) => (dir + 3) % 4,
  'S': (dir) => dir
}

const parseMove = (str) => ({dir: str.substr(0,1), dist:parseInt(str.substr(1))})

const next = (acc, move) => {
  const dir = adjustDir[move.dir](acc.dir);
  return {dir: dir, pos: adjustPos[dir](acc.pos, move.dist)}
}
const distance = (elem) => elem.pos.reduce((sum, i) => sum + Math.abs(i), 0)

const part1 = (moves) => Promise.resolve(moves)
  .then(moves => moves.reduce(next, initPos))
  .then(distance)
  .then(res => console.log("Part 1: " + res))


const explodeMove = (move) => {
  return [{dir: move.dir, dist: 1}]
    .concat(new Array(move.dist - 1).fill({dir: 'S', dist: 1}))
}

const nextWithHistory = (acc, str) => acc.concat([next(acc[acc.length - 1], str)])

const firstDupe = set => elem => {
  const setPos = elem.pos.toString();
  //console.log("setPos: " + setPos)
  if (set.has(setPos) && setPos != "0,0") {
    //console.log("set: " + JSON.stringify(Array.from(set)))
    return true
  } else {
    set.add(setPos);
    return false;
  }
}

const part2 = (moves) => Promise.resolve(moves)
  .then(moves => moves.map(explodeMove).reduce( (acc, moves) => acc.concat(moves), []))
  .then(moves => moves.reduce(nextWithHistory, [initPos]))
  .then(history => history.find(firstDupe(new Set)))
  .then(distance)
  .then(res => console.log("Part 2: " + res))

getStdin()
  .then(stdin => stdin.split(/,\s*/))
  .then((moves) => moves.map(parseMove))
  .then(moves => Promise.all([part1(moves), part2(moves)]))


