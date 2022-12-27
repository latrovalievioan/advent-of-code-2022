const monkeys = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .trim()
  .split('\n')
  .filter(Boolean)
  .reduce((acc, curr) => {
    const [key, value] = curr.split(': ')
    return {...acc, [key]: value}
  },{})

const solve = (key: string, xs: {}) => {
  if(Number.isInteger(Number(xs[key]))) {
    return xs[key];
  }
  const [key1, operation, key2] = xs[key].split(' ')

  return eval(`${solve(key1, xs)} ${operation} ${solve(key2, xs)}`)
}

console.log(solve('root', monkeys))
