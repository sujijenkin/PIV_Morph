/*
 * Macro template to process multiple images in a folder
 */
//#@ File (label = "Input Name of File of files", style = "file") inputFoFname
//#@ File (label = "Input directory", style = "directory") input
//#@ File (label = "Output directory", style = "directory") output
//#@ String (label = "File suffix", value = ".mhd") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.
openFile()
//processInputFile(inputFoFname);

//processFolder(input);

function openFile()
{
	//pathfile=File.openDialog("Choose the file to Open:");
	filenamefile_dir="/DATA/SG/Suji/lidc-idri-DL-projects/segmentation/lumpsome/PIV_segmentation/NoduleSegmentation_PIV/lidc_idri_selected_files.txt"
	filestring=File.openAsString(filenamefile_dir);
	rows=split(filestring, "\n");
	dcmfiles_dir="/DATA/SG/Suji/lidc-idri-DL-projects/segmentation/lumpsome/PIV_segmentation/NoduleSegmentation_PIV/mhdfiles/original_16000/"
	outPIVfiles_dir="/DATA/SG/Suji/lidc-idri-DL-projects/segmentation/lumpsome/PIV_segmentation/NoduleSegmentation_PIV/mhdfiles/PIV_16000/4x/"
//	x=newArray(rows.length);
//	y=newArray(rows.length);
	print("---------------------")
	for(i=0; i<rows.length; i++){
//	for(i=0; i<5; i++){
//	columns=split(rows[i],"\t");
		inputfilepath=dcmfiles_dir+rows[i]+".mhd";
		outputfilepath=outPIVfiles_dir+rows[i];
		print(inputfilepath);
		print(outputfilepath);
		//filepath="/DATA/2021_LUNA_dataset/subset4/1.3.6.1.4.1.14519.5.2.1.6279.6001.910435939545691201820711078950.mhd";
		//filepath="/DATA/2021_LUNA_dataset/subset4/1.3.6.1.4.1.14519.5.2.1.6279.6001.205993750485568250373835565680.mhd";
		//filepath="/DATA/2021_LUNA_dataset/subset0/1.3.6.1.4.1.14519.5.2.1.6279.6001.979083010707182900091062408058.mhd";
		
		//print(filepath);
//		run("MHD/MHA...", "open=/DATA/2021_LUNA_dataset/subset0/1.3.6.1.4.1.14519.5.2.1.6279.6001.979083010707182900091062408058.mhd");
//		filepath="/DATA/2021_LUNA_dataset/subset0/1.3.6.1.4.1.14519.5.2.1.6279.6001.979083010707182900091062408058.mhd"
		run("MHD/MHA...", "open="+inputfilepath);
		run("PIV analysis", "window=4x4 diplay masking=0.50");
		selectWindow("Color coded orientation");
		close();
		selectWindow("U");
		close();
		selectWindow("V");
		close();
		selectWindow("Flow direction");
		close();		
		run("8-bit");
		
		run("MHD/MHA ...", "save=["+outputfilepath+"]");
		selectWindow("Peak height");
		close();
		opfilename=rows[i];
		opfilename = replace(opfilename, ".mhd", ".raw"); 
		print(opfilename);
		selectWindow(opfilename+".raw");
		close();				
//		run("MHD/MHA...", "open=&filepath");
//		print(i);
//		print(filepath);
//		mhdtoPIV(filepath);
	}
	print("---------------------")
//		print(filestring[i]);
//	x[i]=parseInt(columns[0]);
//	y[i]=parseInt(columns[1]);
//	} 
	
	}

function mhdtoPIV(inputFoFname)
{
	//String ip="open="+inputFoFname;
	//print(ip)
	
	//run("MHD/MHA...", "open=/DATA/2021_LUNA_dataset/subset0/1.3.6.1.4.1.14519.5.2.1.6279.6001.979083010707182900091062408058.mhd");
/*	run("PIV analysis", "window=32x32 diplay masking=0.50");
	selectWindow("Color coded orientation");
	close();
	selectWindow("U");
	close();
	selectWindow("V");
	close();
	selectWindow("Flow direction");
	close();*/
/*	selectWindow("Peak height");
	close()
	selectWindow("1.3.6.1.4.1.14519.5.2.1.6279.6001.979083010707182900091062408058.raw");
	close();*/
}

function processInputFile(inputFoFname){
	print("Hello Godfrey")
	FileReader fnr=new FileReader(inputFoFname)
	try (BufferedReader br = new BufferedReader(fnr)) {
    String line;
    while ((line = br.readLine()) != null) {
       System.out.println(line);
    }
}
}

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	print("Saving to: " + output);
}
