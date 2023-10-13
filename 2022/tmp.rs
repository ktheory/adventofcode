use std::collections::HashSet;

fn main() {
    // Create the 3 HashSets.
    let set1: HashSet<&i32> = vec![1, 2, 3, 4, 5].into_iter().collect();
    let set2 = vec![3, 4, 5, 6, 7].into_iter().collect();
    let set3 = vec![5, 6, 7, 8, 9].into_iter().collect();

    // Get the intersection of the 3 HashSets.
    let intersection = set1
        .intersection(&set2)
        .collect::<HashSet<&i32>>()
        .intersection(&set3)
        .collect::<HashSet<&i32>>();

    // Print the intersection.
    println!("{:?}", intersection);
}
