import pandas as pd
import os
import sys


def combine_csv_files(directory, output_file):
    """
    Combine all CSV files in the given directory into one CSV file.

    Parameters:
    directory (str): The path to the directory containing the CSV files.
    output_file (str): The filename for the combined CSV file.
    """
    try:
        # Prepare an empty DataFrame to hold all the data
        one_big_table = pd.DataFrame()

        # Check if the directory exists
        if not os.path.exists(directory):
            print(f"The directory {directory} does not exist.")
            return

        # Check if the directory is empty
        if not os.listdir(directory):
            print(f"The directory {directory} is empty.")
            return

        # Loop through each file in the directory
        for filename in os.listdir(directory):
            if filename.endswith('.csv'):
                # Read the current CSV file into a DataFrame
                df = pd.read_csv(os.path.join(directory, filename))

                # Add a column with the filename (application ID)
                df['application_id'] = filename.replace('.csv', '')

                # Append the current DataFrame to the big table
                one_big_table = pd.concat([one_big_table, df], ignore_index=True)

        # Check if any CSV files were processed
        if one_big_table.empty:
            print(f"No CSV files found in the directory {directory}.")
            return

        # Save the combined DataFrame to a CSV file
        one_big_table.to_csv(output_file, index=False)
        print(f"Combined CSV saved as {output_file}.")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) == 3:
        directory = sys.argv[1]
        output_file = sys.argv[2]
        combine_csv_files(directory, output_file)
    else:
        print("Usage: python combine_csv.py <directory_path> <output_csv_file>")