const matrix: number[][] = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .split('\n')
  .filter(Boolean)
  .map(x => x.split(''))
  .map(list => list.map(x => parseInt(x)))


const transposed = matrix[0].map((col, i) => matrix.map(row => row[i]));

const visible = transposed.map(x => x.map(y => false))

for (let row = 0; row < matrix.length; row++){
  for(let col = 0; col < matrix[row].length; col++){
    const current = matrix[row][col]
    const leftArr = matrix[row].slice(0, col)
    const rightArr = matrix[row].slice(col + 1)
    const upArr = transposed[col].slice(0, row)
    const downArr = transposed[col].slice(row + 1)

    if(
      current > Math.max(...leftArr)
      || current > Math.max(...rightArr)
      || current > Math.max(...upArr)
      || current > Math.max(...downArr)
    ) visible[row][col] = true
  }
}

const solution1 = visible.flatMap(x => x).filter(Boolean).length


// console.log(matrix);
// console.log(transposed);
console.log(solution1);

