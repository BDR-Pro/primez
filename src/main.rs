use std::env;
use primeshor::{is_prime, factorize};
use num_bigint::BigUint;

fn print_factors(number: BigUint) {
    let factors = factorize(number.clone());
    
    println!("{:#?}",factors);
}


fn main() {
    let args: Vec<String> = env::args().collect();


    if args.len() > 1 {
        for (_index, argument) in args.iter().enumerate().skip(1) {
            let number: BigUint = argument.parse().unwrap();
            match is_prime(number.clone()).clone() {
                true => println!("{} is prime!", number),
                false => print_factors(number) ,
            }
        }
    } else {
        let ascii = r#"
        



        ____       _                ______ 
        |  _ \ _ __(_)_ __ ___   ___|__  / |
        | |_) | '__| | '_ ` _ \ / _ \ / /| |
        |  __/| |  | | | | | | |  __// /_|_|
        |_|   |_|  |_|_| |_| |_|\___/____(_)
        
        

        "#;
        println!("{}",ascii);
        println!("Usage: primez <number> <number> ...");
    }
}
