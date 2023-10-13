use std::{collections::HashSet, fs, hash::Hash, slice::Chunks};

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

type Group = (Option<str>, Option<str>, Option<str>);
// fn group_reducer(acc: Vec<Group>, line: &str) -> Vec<Group> {
//     let last = acc.pop().unwrap_or((None, None, None));
//     if last.0.is_none() {
//         acc.push((Some(line.copied()), None, None))
//     } else if last.1.is_none() {
//         acc.push((last.0, line.copied(), None))
//     } else if last.2.is_none() {
//         acc.push((last.0, last.1, line.copied()))
//     } else {
//         acc.push(last);
//         acc.push((Some(line.copied()), None, None))
//     }
// }

// fn parse_lines_2(str: &str) -> u32 {
//     let mut sum: u32 = 0;
//     let mut lines: Vec<&str> = Vec::new();
//     for line in str.lines() {
//         lines.push(line);
//         if lines.len() == 3 {
//             let h0: HashSet<char> = lines[0].chars().collect();
//             let h1: HashSet<char> = lines[1].chars().collect();
//             let h2: HashSet<char> = lines[2].chars().collect();

//             let c: char = h0
//                 .intersection(&h1)
//                 .collect::<HashSet<char>>()
//                 .clone()
//                 .intersection(&h2)
//                 .next()
//                 .expect("no intersection")
//                 .clone();
//         }
//     }
//     return 0;
// }

// via https://users.rust-lang.org/t/intersection-of-multiple-hashsets/85318/3
fn intersections<T>(sets: &[&HashSet<T>]) -> HashSet<T>
where
    T: Clone + Eq + Hash,
{
    match sets.len() {
        0 => HashSet::new(),
        _ => sets[1..].iter().fold(sets[0].clone(), |mut acc, set| {
            acc.retain(|item| set.contains(item));
            acc
        }),
    }
}

fn score_group(group: &[&str]) -> u32 {
    let hashsets: [&HashSet<char>] = group
        .into_iter()
        .map(|v| v.chars().collect::<&HashSet<char>>())
        .collect();
    let i = intersections(hashsets);
    0
}

fn main() {
    let str = fs::read_to_string("2022/3.txt").expect("Error in reading the file");
    // let l = str.lines().next().expect("omg");

    let p1: u32 = str
        .lines()
        .map(|l| score(&find_dupe(parse_knapsack(l))).expect("no score"))
        .sum();
    println!("{}", p1);

    // let slice = ['l', 'o', 'r', 'e', 'm'];
    // let x: _ = slice.chunks(2).collect();
    // println!("{}", x)

    let groups = str.lines().collect::<Vec<&str>>().chunks(3);
    // let g = groups.map(f)

    // let groups = lines.chunks(3)

    // let mut groups =
}
