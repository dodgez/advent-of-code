//! 2015 Advent Of Code solutions
#![allow(unused_variables)]

use std::cmp;
use std::collections::HashMap;

/// Returns the number of `(`s minus the number of `)`s in `input`
pub fn day1(input: String) -> i32 {
    input.chars().fold(0, |acc, c| match c {
        '(' => acc + 1,
        ')' => acc - 1,
        '\n' => acc,
        '\r' => acc,
        c => panic!("Invalid input {}", c),
    })
}

/// Returns the first index where the number of `(`s minus the number of `)`s
///  is less than zero in `input`
pub fn day1_part2(input: String) -> i32 {
    // Acc : (acc, first index of acc < 0, completed)
    input.chars().fold((0, 0, false), |acc, c| {
        if acc.2 { acc }
        else if acc.0 < 0 { (acc.0, acc.1, true) }
        else {
            (match c {
                '(' => acc.0 + 1,
                ')' => acc.0 - 1,
                '\n' => acc.0,
                '\r' => acc.0,
                c => panic!("Invalid input {}", c),
            }, acc.1 + 1, acc.2)
        }
    }).1
}

/// Returns surface area of right rectangular prism with dimensions `l`x`w`x`h`
///  plus the surface area of the smallest side
fn day2_calculate_area((l, w, h) : (u32, u32, u32)) -> u32 {
    let side1 = l * w;
    let side2 = w * h;
    let side3 = l * h;
    return 2*side1 + 2*side2 + 2*side3 + cmp::min(cmp::min(side1, side2), side3);
}

fn day2_parse(dimensions: &str) -> (u32, u32, u32) {
    let mut numbers = Vec::new();
    let mut cur_num = Vec::new();
    for c in dimensions.chars() {
        if c.is_digit(10) {
            cur_num.push(c.to_digit(10).unwrap());
        } else {
            numbers.push(if cur_num.len() < 2 {
                cur_num[0]
            } else {
                cur_num[1..].iter().fold(cur_num[0], |acc, i| acc * 10 + i)
            });
            cur_num.clear();
        }
    }
    numbers.push(if cur_num.len() < 2 {cur_num[0]} else {cur_num[1..].iter().fold(cur_num[0], |acc, i| acc * 10 + i)});
    (numbers[0], numbers[1], numbers[2])
}

/// Returns the sum of the square feet for each dimension in
///  `dimensions` using `day3_calculate_area`
pub fn day2(dimensions: String) -> u32 {
    dimensions.lines().fold(0, |acc, dim| acc + day2_calculate_area(day2_parse(dim)))
}

// Returns the volume of `l`x`w`x`h` plus the smallest perimeter
fn day2_calculate_ribbon((l, w, h) : (u32, u32, u32)) -> u32 {
    let perimeter1 = 2*l + 2*w;
    let perimeter2 = 2*w + 2*h;
    let perimeter3 = 2*l + 2*h;
    return l*w*h + cmp::min(cmp::min(perimeter1, perimeter2), perimeter3);
}

pub fn day2_part2(dimensions: String) -> u32 {
    dimensions.lines().fold(0, |acc, dim| acc + day2_calculate_ribbon(day2_parse(dim)))
}

fn day3_update_map(pos: (i32, i32), m: &mut HashMap<(i32, i32), u32>, direction: (i32, i32)) -> (i32, i32) {
    let new_pos = (pos.0 + direction.0, pos.1 + direction.1);
    let prev_val = m.entry(new_pos).or_insert(0);
    *prev_val += 1;
    new_pos
}

fn day3_translate_direction(c: char) -> (i32, i32) {
    match c {
        '^' => (0, 1),
        '>' => (1, 0),
        'v' => (0, -1),
        '<' => (-1, 0),
        _ => panic!("Invalid direction {}", c)
    }
}

pub fn day3(directions: String) -> u32 {
    let mut pos = (0, 0);
    let mut m = HashMap::new();
    m.insert(pos, 1);
    for direction in directions.chars().filter_map(|c| if c != '\r' && c != '\n' {Some(day3_translate_direction(c))} else {None}) {
        pos = day3_update_map(pos, &mut m, direction);
    }
    m.iter().fold(0, |acc, (k, v)| if *v >= 1 { acc + 1 } else { acc })
}

pub fn day3_part2(directions: String) -> u32 {
    let mut pos = (0, 0);
    let mut m = HashMap::new();
    m.insert(pos, 1);
    for direction in directions.chars().enumerate().filter_map(|(i, c)| if i % 2 == 0 && c != '\r' && c != '\n' {Some(day3_translate_direction(c))} else {None}) {
        pos = day3_update_map(pos, &mut m, direction);
    }
    pos = (0, 0);
    for direction in directions.chars().enumerate().filter_map(|(i, c)| if i % 2 == 1 && c != '\r' && c != '\n' {Some(day3_translate_direction(c))} else {None}) {
        pos = day3_update_map(pos, &mut m, direction);
    }
    m.iter().fold(0, |acc, (k, v)| if *v >= 1 { acc + 1 } else { acc })
}
