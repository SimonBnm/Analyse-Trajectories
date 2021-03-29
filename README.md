# Kinovea Trajectories Evaluation

Analyse larval movement of a single group (Calculate_Distance.R)
1.	Safe your text files from the Kinovea tracking program in folders referring to the 
Experiment and Fly Group (for example “Starved” -> “ForR”).
2.	Open the Calculate_Distance.R script in R studio.
3.	Make sure the required libraries are installed.
4.	Set working directory by changing setwd to the file path where your folders are stored.
5.	Change Experiment to the name of the experiment (= name of the Experiment folder, for example “Starved”) and Group to the fly group (= name of Group folder in the Experiment folder, for example “ForR”) you want to evaluate. If you have no subfolders in the Experiment-folder you need to adjust the code.
6.	Run the script -> A csv-file is generated containing information about the name of the Experiment and Group, the distances in cm of each larva and the time of the first movement of each larva. To adjust where this file should be stored change setwd above the write.csv function to your desired file path. 
7.	The plotted trajectories containing information about the name of the text file and the calculated distance can now be checked for each file.
8.	You can also check the bar plots of mean distance and mean time of first movement.


Compare larval movement data of different groups (Compare_Distances.R)
1.	Store the csv-files from the previous script in a folder where the same experimental groups are in the same folder (for example “Starved” folder contains the csv files of “Starved_ForR” and “Starved_ForS”).
2.	Open the Compare_Distances.R script in R studio
3.	Make sure the required libraries are installed.
4.	Set working directory by changing setwd to the file path where your folder containing the different experimental groups is stored
5.	Run the script.


