type Monkey = {
  startingItems: number[];
  operation: (x: number) => number;
  test: (x: number) => boolean;
  to: {
    yes: number;
    no: number;
  }
  inspectCount: number;
}

const testMonkeys: Monkey[] = [
  {
    startingItems: [79, 98],
    operation: (old: number) => old * 19,
    test: (x: number) => x % 23 == 0,
    to: {
      yes: 2,
      no: 3,
    },
    inspectCount: 0,
  },
  {
    startingItems: [54, 65, 75, 74],
    operation: (old: number) => old + 6,
    test: (x: number) => x % 19 == 0,
    to: {
      yes: 2,
      no: 0,
    },
    inspectCount: 0,
  },
  {
    startingItems: [79, 60, 97],
    operation: (old: number) => old * old,
    test: (x: number) => x % 13 == 0,
    to: {
      yes: 1,
      no: 3,
    },
    inspectCount: 0,
  },
  {
    startingItems: [74],
    operation: (old: number) => old + 3,
    test: (x: number) => x % 17 == 0,
    to: {
      yes: 0,
      no: 1,
    },
    inspectCount: 0,
  },
]

const realMonkeys: Monkey[] = [
  {
    startingItems: [73, 77],
    operation: (old: number) => old * 5,
    test: (x: number) => x % 11 == 0,
    to: {
      yes: 6,
      no: 5,
    },
    inspectCount: 0,
  },
  {
    startingItems: [57, 88, 80],
    operation: (old: number) => old + 5,
    test: (x: number) => x % 19 == 0,
    to: {
      yes: 6,
      no: 0,
    },
    inspectCount: 0,
  },
  {
    startingItems: [61, 81, 84, 69, 77, 88],
    operation: (old: number) => old * 19,
    test: (x: number) => x % 5 == 0,
    to: {
      yes: 3,
      no: 1,
    },
    inspectCount: 0,
  },
  {
    startingItems: [78, 89, 71, 60, 81, 84, 87, 75],
    operation: (old: number) => old + 7,
    test: (x: number) => x % 3 == 0,
    to: {
      yes: 1,
      no: 0,
    },
    inspectCount: 0,
  },
  {
    startingItems: [60, 76, 90, 63, 86, 87, 89],
    operation: (old: number) => old + 2,
    test: (x: number) => x % 13 == 0,
    to: {
      yes: 2,
      no: 7,
    },
    inspectCount: 0,
  },
  {
    startingItems: [88],
    operation: (old: number) => old + 1,
    test: (x: number) => x % 17 == 0,
    to: {
      yes: 4,
      no: 7,
    },
    inspectCount: 0,
  },
  {
    startingItems: [84, 98, 78, 85],
    operation: (old: number) => old * old,
    test: (x: number) => x % 7 == 0,
    to: {
      yes: 5,
      no: 4,
    },
    inspectCount: 0,
  },
  {
    startingItems: [98, 89, 78, 73, 71],
    operation: (old: number) => old + 4,
    test: (x: number) => x % 2 == 0,
    to: {
      yes: 3,
      no: 2,
    },
    inspectCount: 0,
  },
]

const inspect = (worryLevel: number, operation: (old: number) => number): number => Math.floor(operation(worryLevel) / 3)

const turn = (monkey: Monkey): void => {
  while(monkey.startingItems.length){
    monkey.inspectCount++
    const itemToThrow = inspect(monkey.startingItems.shift(), monkey.operation)
    const receivingMonkeyIndex = monkey.test(itemToThrow) ? monkey.to.yes : monkey.to.no
    realMonkeys[receivingMonkeyIndex].startingItems.push(itemToThrow)
  }
}

const round = (monkeys: Monkey[]) => {
  monkeys.forEach(m => {
    turn(m)
  })
}

for(let i = 0; i < 20; i++){
  round(realMonkeys)
}

const counts = realMonkeys.map(m => m.inspectCount).sort((a, b) => a - b)

console.log(counts[counts.length - 1] * counts[counts.length - 2])



















