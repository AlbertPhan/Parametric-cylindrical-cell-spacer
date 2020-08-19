// Cylindrical battery spacers
// Albert Phan August 8 2020
// This parametric openscad generates spacers for putting inbetween cylindrical cells such as 18650s for battery building
$fn = 100;
num_cells = 12;
num_rows = 2;
cell_dia = 18.5;
height = 40; // Height of the spacer eg you can have it the height of the cell or print 2 spacers for top and bottom
spacing = 0.8; // Space between the cells
cutout_start = 3;   // cell number to start top cutout
cutout_end = 10;    // cell number to end top cutout
holding_extra = 5; // extra amount to hold the cell in the spacer

extra = 0.1; //

// Method:
// Generate cube for entire section
// iterate through the rows then columns 
// difference each cell from the cube


difference()
{
translate([0,0,-height/2])
    
linear_extrude(height)
polygon([[-(cell_dia/2+spacing),-holding_extra],
    [num_cells*(cell_dia+spacing) + spacing/2,-holding_extra],
    [num_cells*(cell_dia + spacing)+spacing/2,(num_rows-1) * sin(60)*(cell_dia+spacing) +holding_extra],
    [-(cell_dia/2+spacing),(num_rows-1) * sin(60)*(cell_dia+spacing)+holding_extra]]);

    for(row = [0:num_rows-1])
    {

        if ((row % 2) == 0)
        {            
            translate([0,sin(60)*(cell_dia+spacing)*row,0])
            for(col = [0:num_cells])
            {
                translate([(cell_dia+spacing)*col,0,0])
                    cylinder(h = height + extra, d = cell_dia, center = true);
            }                
        }
        else    // offset row
        {
            translate([(cell_dia/2+spacing/2),sin(60)*(cell_dia+spacing)*row,0])
            for(col = [0:num_cells])
            {
                translate([(cell_dia + spacing)*col,0,0])
                   cylinder(h = height + extra, d = cell_dia, center = true);
            }
        }
	}		
translate([(cutout_start-0.5)*(cell_dia+spacing), (cell_dia/2 + spacing),-(height+extra)/2])
cube([(cutout_end-cutout_start)*(cell_dia+spacing),cell_dia,height+extra]);
    
// First cell cutouts
translate([-(cell_dia/2 + spacing/2),sin(60)*(cell_dia+spacing),0])
cylinder(h = height + extra, d = cell_dia, center = true);
}
