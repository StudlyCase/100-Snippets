const groupBy = (arr, key) =>
  arr.reduce((acc, item) => {
    const group = item[key];
    acc[group] = acc[group] ? [...acc[group], item] : [item];
    return acc;
  }, {});

const people = [
  { name: "Alice", city: "Berlin" },
  { name: "Bob", city: "Munich" },
  { name: "Clara", city: "Berlin" },
  { name: "David", city: "Munich" },
  { name: "Eva", city: "Hamburg" },
];

console.log(groupBy(people, "city"));
