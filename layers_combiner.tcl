


proc layer_combiner_script {} {
    global path_layers_dir
    global file_list
    global cells_list
    puts $path_layers_dir

    eval {cd $path_layers_dir}

    if { [catch {set file_list [glob *.oas -directory path_layers_dir] } ] } {
        set cells_list [list]
        set file_list [list]
        tk_messageBox -message "No .oas files found" -type ok
    } 

}



proc file_list_box_Selected {list_box} {

    global path_layers_dir
    global file_list
    global cells_list
    set INDEX_active [lindex [$list_box curselection]]

    set current_topcell [layout peek $path_layers_dir/[lindex $file_list $INDEX_active] -topcells]

    set cells_list_temp [layout peek $path_layers_dir/[lindex $file_list $INDEX_active] -child $current_topcell]

    set cells_list [lindex [lindex $cells_list_temp 0] 1]

    puts $cells_list
}    
     
    
    




proc layer_combiner_gui {wbHandle window} {
    
    set top .topframe
    toplevel $top -borderwidth 200
    wm title $top "LayerCombiner"
    
    
    global path_layers_dir
    set path_layers_dir "Enter directory path..."

    entry $top.cmd -width 50 -relief sunken -textvariable path_layers_dir
    pack $top.cmd -side top -fill x -expand true
    
    button $top.run -text LOAD -command layer_combiner_script
    pack $top.run -side top
    

    button $top.choosedir -text CHOOSE -command {set path_layers_dir [tk_chooseDirectory]}
    pack $top.choosedir -side left
    
    global file_list
    set file_list_box [listbox $top.file_list_box -listvariable file_list -width 20]
    pack $top.file_list_box -side left
    bind $top.file_list_box <ButtonRelease-1> {file_list_box_Selected %W}



    



    global cells_list
    listbox $top.cells_list_box -listvariable cells_list -width 25
    pack $top.cells_list_box -side right
}




# Macro initialisation
if {[ isTkLoaded ]} {

    Macros create "LAYER COMBINER" layer_combiner_script layer_combiner_gui
}