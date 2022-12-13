use std::{collections::HashSet, fs};

type Knapsacks<'a> = (&'a str, &'a str);

fn parse_knapsack(s: &str) -> Knapsacks {
    (&s[0..(s.len() / 2)], &s[(s.len() / 2)..s.len()])
}

fn find_dupe(k: Knapsacks) -> char {
    let h1: HashSet<char> = k.0.chars().collect();
    let h2: HashSet<char> = k.1.chars().collect();

    h1.intersection(&h2)
        .next()
        .expect("no intersection")
        .clone()
}

fn score(c: &char) -> Option<u32> {
    let i = *c as u32;
    match i {
        65..=90 => Some(i - 38),
        97..=122 => Some(i - 96),
        _ => None,
    }
}

// fn group_reducer(lines: Lines<_>) ->

fn main() {
    let str = fs::read_to_string("2022/3.txt").expect("Error in reading the file");
    // let l = str.lines().next().expect("omg");

    let p1: u32 = str
        .lines()
        .map(|l| score(&find_dupe(parse_knapsack(l))).expect("no score"))
        .sum();
    println!("{}", p1);

    // let p2 = str.lines().array_chunks::<3>()

    // println!("{:#?}", p2)
    // println!("{:#?}", parse_knapsack(l));
    // println!("{:#?}", score(&find_dupe(parse_knapsack(l))));
    // println!("{:#?}", score(&'Z'))
}
