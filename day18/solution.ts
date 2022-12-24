type CubePosition = {
  x: number; 
  y: number; 
  z: number
};

const cubePositions: CubePosition[] = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .trim()
  .split('\n')
  .filter(Boolean)
  .map((line: string) => line
    .split(',')
    .map((n: string) => Number(n))
  )
  .map((line: number[]) => ({
    x: line[0],
    y: line[1],
    z: line[2],
  }));

let sidesCount = cubePositions.length * 6

const getNeighborPositions = ({x, y, z}: CubePosition): CubePosition[] => (
  [
    {
      x: x + 1,
      y,
      z,
    },
    {
      x: x - 1,
      y,
      z,
    },
    {
      x,
      y: y + 1,
      z,
    },
    {
      x,
      y: y - 1,
      z,
    },
    {
      x,
      y,
      z: z + 1,
    },
    {
      x,
      y,
      z: z - 1,
    },
  ]
);

const stringifiedCubePositions = cubePositions.map(x => JSON.stringify(x));

for (let i = 0; i < cubePositions.length; i++){
  const neighborPositions = getNeighborPositions(cubePositions[i]);
  for (let j = 0; j < neighborPositions.length; j++){
    if(stringifiedCubePositions.includes(JSON.stringify(neighborPositions[j]))) sidesCount--
  }
}

console.log(sidesCount)
