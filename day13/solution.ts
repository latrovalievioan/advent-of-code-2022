const packetPairs: any[] = require(`fs`)
  .readFileSync(`./input1`, `utf-8`)
  .split('\n\n')
  .map((x: string) => x.split('\n'))
  .map((x: string[]) => x.filter(Boolean))
  .map((x: string[]) => x.map((y:string) => eval(y)));

const rightOrderIndexes = [];

const compare = (a: any, b: any): -1 | 0 | 1 => {

  if(a === undefined && b === undefined) return 0;
  if(a === undefined && b !== undefined) return -1;
  if(a !== undefined && b === undefined) return 1;
  
  if(Number.isInteger(a) && Number.isInteger(b)) return a === b ? 0 : a < b ? -1 : 1

  if(Array.isArray(a) && Array.isArray(b)) {
    let maxLen = Math.max(a.length, b.length);
    let i = 0
    let result: -1 | 0 | 1 = 0
    while(result === 0 && i < maxLen){
      result = compare(a[i],b[i])
      i++
    }
    return result;
  }

  if(Number.isInteger(a) && Array.isArray(b)) return compare([a], b)
  if(Array.isArray(a) && Number.isInteger(b)) return compare(a, [b])
}

packetPairs.forEach((p: string[], i: number) => {
  if(compare(p[0], p[1]) === -1) rightOrderIndexes.push(i + 1)
})

console.log(rightOrderIndexes.reduce((a,c) => a + c, 0));

packetPairs.push([[2]])
packetPairs.push([[6]])
const sortedStrings = packetPairs.flat(1).sort((a,b) => compare(a,b)).map(x => `${x}`)
console.log((sortedStrings.indexOf("2") + 1) * (sortedStrings.indexOf("6") + 1))
