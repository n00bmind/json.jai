#import "Basic";
#import "Compiler";

#import "unotest";


build :: ()
{
    set_build_options_dc( .{do_output=false} );  // No executable for this workspace.

    global_options := get_build_options();
    global_options.output_path = "bin";
    global_options.intermediate_path = "bin";

    build_release := false;
    args := global_options.compile_time_command_line;

    // NOTE These arguments have to be specified last, after any arguments for the compiler itself, separated with a hyphen, e.g:
    // jai build.jai - release
    for arg: args
    {
        if arg ==
        {
            case "--release"; #through;
            case "-release"; #through;
            case "release";
                build_release = true;
                print( "Building release version.\n" );
        }
    }

    if build_release
    {
        set_optimization( *global_options, .VERY_OPTIMIZED, true );
        global_options.backend =.LLVM;
    }
    else
    {
        set_optimization( *global_options, .DEBUG, true );
        global_options.backend =.X64;
    }


    // Test executable
    {
        w := BuildTestWorkspace( "Tests", global_options, .[ "tests/test.jai" ] );
    }

}
#run build();

