let matrix_: string[][] = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .trim()
  .split('\n')
  .filter(Boolean)
  .map((x: string) => x.split(''))

const printPretty = (m: any[][]) => m.forEach(r => console.log(r));

const render = (matrix: boolean[][]): void  => {
  const tochici = matrix.map(x => x.map(y => y ? '#' : '.').join('')).join('\n')
  console.log(tochici, '\n');
};

const getSE = (matrix: string[][]) => {
  let s = [-1, -1];
  let e = [-1, -1];

  for(let i = 0; i < matrix.length; i++){
    for(let j = 0; j < matrix[i].length; j++){
      if (matrix[i][j] === 'S') s = [i, j]
      if (matrix[i][j] === 'E') e = [i, j]
    }
  }

  return {s, e}
};

const {s, e} = getSE(matrix_);

const [sR, sC] = s;
const [eR, eC] = e;

matrix_ = matrix_.map(x => x.map(y => y === 'S' ? 'a' : y === 'E' ? 'z' : y));

const getUnvisitedNeighbors = (r: number, c: number, visited: boolean[][]): number[][] => {
  const neighbors: number[][] = [];

  const currElevation =
    r === sR && c === sC
      ? 'a'.charCodeAt(0)
      : r === eR && c === eC
        ? 'z'.charCodeAt(0)
        : matrix_[r][c].charCodeAt(0);

  if(matrix_[r - 1] && (matrix_[r - 1][c].charCodeAt(0) <= currElevation + 1))
    neighbors.push([r - 1, c])

  if(matrix_[r + 1] && (matrix_[r + 1][c].charCodeAt(0) <= currElevation + 1))
    neighbors.push([r + 1, c])

  if(matrix_[r][c - 1] && matrix_[r][c - 1].charCodeAt(0) <= currElevation + 1)
    neighbors.push([r, c - 1])

  if(matrix_[r][c + 1] && matrix_[r][c + 1].charCodeAt(0) <= currElevation + 1)
    neighbors.push([r, c + 1])

  return neighbors.filter(([r, c]) => !visited[r][c]);
};

console.log(eR, eC);

const bfs = () => {
  const visited = matrix_.map(x => x.map(_ => false));
  const queue = [[sR, sC, 0]];
  visited[sR][sC] = true

  while(queue.length){
    const [r, c, d] = queue.pop();

    if(r === eR && c === eC) {
      return d
    };

    const neighbors = getUnvisitedNeighbors(r, c, visited)

    neighbors.forEach((n: number[]) => {
      visited[n[0]][n[1]] = true
      queue.unshift([...n, d + 1])
    })
    // render(visited);
  }
  // console.log(x)
}
const visited = matrix_.map(x => x.map(_ => false));

console.log(bfs());
