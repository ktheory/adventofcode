#!/usr/bin/env node

const getStdin = require('get-stdin');

const move = {
  'U': (cur) => cur < 4 ? cur : cur - 3,
  'D': (cur) => cur > 6 ? cur : cur + 3,
  'L': (cur) => cur % 3 == 1 ? cur : cur - 1,
  'R': (cur) => cur % 3 == 0 ? cur : cur + 1
}

const findDigit = (moves) => moves.reduce((cur, m) => move[m](cur), 5)

const part1 = (cmds) => Promise.resolve(cmds)
  .then(cmds => cmds.map(findDigit).join(''))
  .then(console.log)

//     1
//   2 3 4
// 5 6 7 8 9
//   A B C
//     D
//
//     A = 10, B = 11, C = 12, D = 13
const move2 = {
  'U': (cur) => [5,2,1,4,9].includes(cur) ? cur : [3, 13].includes(cur) ? cur - 2 : cur - 4,
  'D': (cur) => [5,10,13,12,9].includes(cur) ? cur : [1, 11].includes(cur) ? cur + 2 : cur + 4,
  'L': (cur) => [1,2,5,10,13].includes(cur) ? cur : cur - 1,
  'R': (cur) => [1,4,9,12,13].includes(cur) ? cur : cur + 1
}

const findDigit2 = (moves) => moves.reduce((cur, m) => move2[m](cur), 5)

const part2 = (cmds) => Promise.resolve(cmds)
  .then(cmds => cmds.map(findDigit2))
  .then(digits => digits.map(d => d.toString(16).toUpperCase()).join(''))
  .then(console.log)


getStdin()
  .then(stdin => stdin.split(/\n/).map(line => line.split('')))
  .then(cmds => Promise.all([part1(cmds), part2(cmds)]))


