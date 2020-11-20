use advent_of_code::twenty_fifteen::*;

#[test]
fn day1_test() {
    assert_eq!(day1("(())".to_string()), 0);
    assert_eq!(day1("()()".to_string()), 0);

    assert_eq!(day1("(((".to_string()), 3);
    assert_eq!(day1("(()(()(".to_string()), 3);
    assert_eq!(day1("))(((((".to_string()), 3);

    assert_eq!(day1("())".to_string()), -1);
    assert_eq!(day1("))(".to_string()), -1);

    assert_eq!(day1(")))".to_string()), -3);
    assert_eq!(day1(")())())".to_string()), -3);
}

#[test]
fn day1_part2_test() {
    assert_eq!(day1_part2(")".to_string()), 1);
    assert_eq!(day1_part2("()())".to_string()), 5);
}

#[test]
fn day2_test() {
    assert_eq!(day2("2x3x4".to_string()), 58);
    assert_eq!(day2("1x1x10".to_string()), 43);
}

#[test]
fn day2_part2_test() {
    assert_eq!(day2_part2("2x3x4".to_string()), 34);
    assert_eq!(day2_part2("1x1x10".to_string()), 14);
}

#[test]
fn day3_test() {
    assert_eq!(day3(">".to_string()), 2);
    assert_eq!(day3("^>v<".to_string()), 4);
    assert_eq!(day3("^v^v^v^v^v".to_string()), 2);
}

#[test]
fn day3_part2_test() {
    assert_eq!(day3_part2("^v".to_string()), 3);
    assert_eq!(day3_part2("^>v<".to_string()), 3);
    assert_eq!(day3_part2("^v^v^v^v^v".to_string()), 11);
}
