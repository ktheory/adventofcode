#!/usr/bin/env node

const getStdin = require('get-stdin');

const parseLine = (line) => line.replace(/^\s+/, '')
  .split(/\s+/)
  .map(i => parseInt(i))
  .sort((a,b) => a - b)

const isTriangle = (sides) => {
  return sides[0] + sides[1] > sides[2];
}
const part1 = (lines) => Promise.resolve(lines)
  .then(lines => lines.filter(isTriangle))
  .then(lines => lines.length)

const part2 = (lines) => Promise.resolve(lines)
  .then(lines => lines.map


const lines = getStdin()
  .then(stdin => stdin.split(/\n/).map(parseLine))

lines
  .then(part1)
  .then(res => console.log("Part 1: " + res))

lines
  .then(part2)
  .then(res => console.log("Part 2: " + res))


