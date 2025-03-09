#import "unotest";

#import,file "../json.jai";


test_empty_object :: ()
{
    payload: string = "{}";
    value: *json_value_s = json_parse( payload.data, xx payload.count );

    Assert( value != null );
    Assert( value.payload != null );
    Assert( .json_type_object == value.type );

    object := cast(*json_object_s)value.payload;

    Assert( object.start == null );
    Assert( object.length == 0 );

    free( value );
} @test
