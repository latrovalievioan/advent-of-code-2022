const matrix: number[][] = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .split('\n')
  .filter(Boolean)
  .map(x => x.split(''))
  .map(list => list.map(x => parseInt(x)))


const transposed = matrix[0].map((col, i) => matrix.map(row => row[i]));

const visible = transposed.map(x => x.map(y => false))

const scores = transposed.map(x => x.map(y => 0))

for (let row = 0; row < matrix.length; row++){
  for(let col = 0; col < matrix[row].length; col++){
    const current = matrix[row][col]
    const leftArr = matrix[row].slice(0, col)
    const rightArr = matrix[row].slice(col + 1)
    const upArr = transposed[col].slice(0, row)
    const downArr = transposed[col].slice(row + 1)

    //part 1
    if(
      current > Math.max(...leftArr)
      || current > Math.max(...rightArr)
      || current > Math.max(...upArr)
      || current > Math.max(...downArr)
    ) visible[row][col] = true

    //part 2
    let visiblesLeft = 0
    for (let i = leftArr.length - 1; i >= 0; i--){
      visiblesLeft++
      if(current <= leftArr[i]) break
    }
    
    let visiblesRight = 0
    for (let i = 0; i < rightArr.length; i++){
      visiblesRight++
      if(current <= rightArr[i]) break
    }

    let visiblesUp = 0
    for (let i = upArr.length - 1; i >= 0; i--){
      visiblesUp++
      if(current <= upArr[i]) break
    }

    let visiblesDown = 0
    for (let i = 0; i < downArr.length; i++){
      visiblesDown++
      if(current <= downArr[i]) break
    }

    scores[row][col] = visiblesLeft * visiblesRight * visiblesUp * visiblesDown
  }
}

const solution1 = visible.flatMap(x => x).filter(Boolean).length
const solution2 = Math.max(...scores.flatMap(x => x))


console.log(solution1);
console.log(solution2);

