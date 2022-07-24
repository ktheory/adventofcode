import * as fs from 'fs/promises';
import * as path from 'path';

const reducer1 = (acc: number[], cur: string): number[] => {
  const [dir, ns] = cur.split(' ')
  const n = Number(ns)
  switch (dir) {
    case 'forward':
      return [acc[0] + n, acc[1]]
    case 'down':
      return [acc[0], acc[1] + n]
    case 'up':
      return [acc[0], acc[1] - n]
    default:
      throw(new Error('invalid direction'))
  }
}

const result = fs.readFile(path.join(__dirname, '2.txt'), 'utf8')
.then(x => x.split('\n').reduce(reducer1, [0, 0]))
.then(x => console.log(x[0]* x[1]))


const reducer2 = (acc: number[], cur: string): number[] => {
  const [dir, ns] = cur.split(' ')
  const n = Number(ns)
  switch (dir) {
    case 'forward':
      return [acc[0] + n, acc[1]+ (acc[2]*n), acc[2]]
    case 'down':
      return [acc[0], acc[1], acc[2] + n]
    case 'up':
      return [acc[0], acc[1], acc[2] - n]
    default:
      throw(new Error('invalid direction'))
  }
}

fs.readFile(path.join(__dirname, '2.txt'), 'utf8')
.then(x => x.split('\n').reduce(reducer2, [0, 0, 0]))
.then(x => console.log("Part 2: " + x[0]* x[1]))
