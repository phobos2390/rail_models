$fn = 40;

$scale = 2;
$grade = 20 * $scale;
$length = 40 * $scale;
$height = 20 * $scale;
$thickness = 1 * $scale;
$tolerance = 1;

$wheel_radius = 6 * $scale;
$wheel_base_thickness = 1.5 * $scale;
$wheel_flange_thickness = .5 * $scale;
$wheel_flange_width = .5 * $scale;
$wheel_elliptical_cutout_radial_length_scale = 2 * $scale;
$wheel_elliptical_cutout_radial_thickness_scale = 1 * $scale;

$axel_radius = .5 * $scale;

axel_set(3, 3, $grade, $tolerance, $wheel_base_thickness, $axel_radius);


//wheel_set( 2
//         , 2
//         , $wheel_radius
//         , $wheel_base_thickness
//         , $wheel_flange_thickness
//         , $wheel_flange_width
//         , $wheel_elliptical_cutout_radial_length_scale
//         ,$wheel_elliptical_cutout_radial_thickness_scale
//         ,$axel_radius
//         , $tolerance);


module wheel_set( num_rows
                , num_columns
                , wheel_radius
                , wheel_base_thickness
                , wheel_flange_thickness
                , wheel_flange_width
                , wheel_elliptical_cutout_radial_length_scale
                , wheel_elliptical_cutout_radial_thickness_scale
                , axel_radius
                , tolerance)
{
    for(i = [0:1:num_rows-1])
    {
        for(j = [0:1:num_columns-1])
        {
            translate([(2*wheel_radius+tolerance) * i, (2*wheel_radius+tolerance) * j,0])
            {
                wheel(                , wheel_radius
                , wheel_base_thickness
                , wheel_flange_thickness
                , wheel_flange_width
                , wheel_elliptical_cutout_radial_length_scale
                , wheel_elliptical_cutout_radial_thickness_scale
                , axel_radius
                , tolerance);
            }
        }
    }
}

module axel_set(num_rows, num_columns, grade, tolerance, wheel_base_thickness, axel_radius)
{
    for(i = [0:1:num_rows-1])
    {
        for(j = [0:1:num_columns-1])
        {
            translate([(2*axel_radius+tolerance) * i, (2*axel_radius+tolerance) * j,0])
            {
                axel(grade, tolerance, wheel_base_thickness, axel_radius);
            }
        }
    }
}

module cart(height, grade, length, thickness, tolerance)
{
    #rotate(180, [0,1,0])
    {
        difference() 
        {
            linear_extrude(height)
            {
                square([grade, length], center=true);
            }
            translate([0,0,-tolerance])
            {
                linear_extrude(height - thickness)
                {
                    square([grade - thickness - tolerance, length - thickness - tolerance], center=true);
                }
            }
        }
    }
}

module wheel( wheel_radius,
            , wheel_base_thickness
            , wheel_flange_thickness
            , wheel_flange_width
            , wheel_elliptical_cutout_radial_length_scale
            , wheel_elliptical_cutout_radial_thickness_scale
            , axel_radius
            , tolerance)
{
    rotate_extrude()
    {
        difference()
        {
            union()
            {
                square([wheel_radius + wheel_flange_width, wheel_base_thickness]);
            }
            translate([wheel_radius/2 + axel_radius,wheel_base_thickness,0])
            {
                scale([wheel_elliptical_cutout_radial_length_scale,wheel_elliptical_cutout_radial_thickness_scale,1])
                {
                    circle(1, 1);
                }
            }
            translate([wheel_radius + wheel_flange_width, wheel_base_thickness,0])
            {
                scale([wheel_flange_width,wheel_base_thickness - wheel_flange_thickness])
                {
                    circle(1,1);
                }
            }
            square([axel_radius/2 + tolerance,wheel_base_thickness]);
        }    
    }
}

module axel(grade, tolerance, wheel_base_thickness, axel_radius)
{
    linear_extrude(grade + tolerance * 2 + wheel_base_thickness)circle(axel_radius);
}