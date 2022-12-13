use std::fs;

#[derive(Debug, PartialEq, Eq)]
enum Throw {
    Rock,
    Paper,
    Scissors,
}
#[derive(Debug)]
struct Round {
    opponent: Throw,
    player: Throw,
}

fn get_throw(c: char) -> Option<Throw> {
    match c {
        'A' | 'X' => Some(Throw::Rock),
        'B' | 'Y' => Some(Throw::Paper),
        'C' | 'Z' => Some(Throw::Scissors),
        _ => None,
    }
}

fn score_throw(t: &Throw) -> u32 {
    match t {
        Throw::Rock => 1,
        Throw::Paper => 2,
        Throw::Scissors => 3,
    }
}

fn score_win(r: &Round) -> u32 {
    if (r.opponent == Throw::Rock && r.player == Throw::Scissors)
        || (r.opponent == Throw::Scissors && r.player == Throw::Paper)
        || (r.opponent == Throw::Paper && r.player == Throw::Rock)
    {
        0
    } else if r.opponent == r.player {
        3
    } else {
        6
    }
}

fn score(r: &Round) -> u32 {
    score_throw(&r.player) + score_win(r)
}

fn parse_round(s: &str) -> Round {
    println!("str: {}", s);
    let o: char = s.chars().next().expect("no opponent");
    let p: char = s.chars().last().expect("no player");

    Round {
        opponent: get_throw(o).expect("no opponent"),
        player: get_throw(p).expect("no player"),
    }
}

fn parse_round2(s: &str) -> Round {
    let o = s.chars().next().expect("no opponent");
    let p = s.chars().last().expect("no player");

    let ot = get_throw(o).expect("error");
    let pt = match ot {
        Throw::Rock => {
            if p == 'X' {
                Throw::Scissors
            } else if p == 'Y' {
                Throw::Rock
            } else {
                Throw::Paper
            }
        }
        Throw::Paper => {
            if p == 'X' {
                Throw::Rock
            } else if p == 'Y' {
                Throw::Paper
            } else {
                Throw::Scissors
            }
        }
        _ => {
            if p == 'X' {
                Throw::Paper
            } else if p == 'Y' {
                Throw::Scissors
            } else {
                Throw::Rock
            }
        }
    };

    Round {
        opponent: ot,
        player: pt,
    }
}

fn main() {
    let str = fs::read_to_string("2022/2.txt").expect("Error in reading the file");
    let l = str.lines().next().expect("omg");
    // println!("{}", l);
    let round = parse_round(l);
    // println!("{:?}", round);
    println!("{:?}", score(&round));
    let sum = str
        .lines()
        // .fold(0, |acc: u32, l| acc + score(&parse_round(l)));
        .fold(0, |acc: u32, l| acc + score(&parse_round2(l)));

    println!("{}", sum)
}
