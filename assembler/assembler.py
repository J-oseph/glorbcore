import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-i", "--input_file",
        type=str,
        required=True,
        help="Assembly code to be assembled!",
    )
    parser.add_argument(
        "-o", "--output_file",
        type=str,
        required=True,
        help="File to be outputted.",
    )
    args = parser.parse_args()
    print(args.input_file)
    print(args.output_file)


if __name__ == '__main__':
    main()
