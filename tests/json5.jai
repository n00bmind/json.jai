
test_allow_json5_example1 :: ()
{
    payload := #string STR
    {
        foo: 'bar',
        while: true,

        this: 'is a \n
        multi-line string',

        // this is an inline comment
        here: 'is another', // inline comment

        /* this is a block comment
            that continues on another line */

        hex: 0xDEADbeef,
        half: .5,
        delta: +10,
        to: Infinity,   // and beyond!

        finally: 'a trailing comma',
        oh: [
                "we shouldn't forget",
                'arrays can have',
                'trailing commas too',
            ],
    }
STR
    value := json_parse(payload.data, xx payload.count, .json_parse_flags_allow_json5, null, null, null);
    Assert(value);
    free(value);
} @test

test_allow_json5_example2 :: ()
{
    payload := #string STR
    // This file is written in JSON5 syntax, naturally, but npm needs a regular
    // JSON file, so compile via `npm run build`. Be sure to keep both in sync!

    {
        name: 'json5',
        version: '0.5.0',
        description: 'JSON for the ES5 era.',
        keywords: ['json', 'es5'],
        author: 'Aseem Kishore <aseem.kishore@gmail.com>',
        contributors: [
            // TODO: Should we remove this section in favor of GitHub's list?
            // https://github.com/json5/json5/contributors
            'Max Nanasy <max.nanasy@gmail.com>',
            'Andrew Eisenberg <andrew@eisenberg.as>',
            'Jordan Tucker <jordanbtucker@gmail.com>',
        ],
        main: 'lib/json5.js',
        bin: 'lib/cli.js',
        files: ["lib/"],
        dependencies: {},
        devDependencies: {
            gulp: "^3.9.1",
            'gulp-jshint': "^2.0.0",
            jshint: "^2.9.1",
            'jshint-stylish': "^2.1.0",
            mocha: "^2.4.5"
        },
        scripts: {
            build: 'node ./lib/cli.js -c package.json5',
            test: 'mocha --ui exports --reporter spec',
                // TODO: Would it be better to define these in a mocha.opts file?
        },
        homepage: 'http://json5.org/',
        license: 'MIT',
        repository: {
            type: 'git',
            url: 'https://github.com/json5/json5',
        },
    }
STR
    value := json_parse(payload.data, xx payload.count, .json_parse_flags_allow_json5, null, null, null);
    Assert(value);
    free(value);
} @test


init_allow_json5 :: () -> *json_value_s
{
    payload := #string STR
    // This file is written in JSON5 syntax, naturally, but npm needs a regular
    // JSON file, so compile via `npm run build`. Be sure to keep both in sync!

    {
        name: 'json5',
        version: '0.5.0',
        description: 'JSON for the ES5 era.',
        keywords: ['json', 'es5'],
        author: 'Aseem Kishore <aseem.kishore@gmail.com>',
        contributors: [
            // TODO: Should we remove this section in favor of GitHub's list?
            // https://github.com/json5/json5/contributors
            'Max Nanasy <max.nanasy@gmail.com>',
            'Andrew Eisenberg <andrew@eisenberg.as>',
            'Jordan Tucker <jordanbtucker@gmail.com>',
        ],
        main: 'lib/json5.js',
        bin: 'lib/cli.js',
        files: ["lib/"],
        dependencies: {},
        devDependencies: {
            gulp: "^3.9.1",
            'gulp-jshint': "^2.0.0",
            jshint: "^2.9.1",
            'jshint-stylish': "^2.1.0",
            mocha: "^2.4.5"
        },
        scripts: {
            build: 'node ./lib/cli.js -c package.json5',
            test: 'mocha --ui exports --reporter spec',
                // TODO: Would it be better to define these in a mocha.opts file?
        },
        homepage: 'http://json5.org/',
        license: 'MIT',
        repository: {
            type: 'git',
            url: 'https://github.com/json5/json5',
        },
    }
STR
    value := json_parse(payload.data, xx payload.count, .json_parse_flags_allow_json5, null, null, null);
    return value;
}

shutdown_allow_json5 :: ( value: *json_value_s )
{
    Assert(value);
    free(value);
}

test_read_write_pretty_read :: ()
{
    root := init_allow_json5();
    Assert(root);

    json := json_write_pretty( root, "  ", "\n" );

    free( root );
    root = json_parse( json );

    free( json );
    shutdown_allow_json5( root );
} @test

test_read_write_minified_read :: ()
{
    root := init_allow_json5();
    Assert(root);

    json := json_write_minified( root );

    free( root );
    root = json_parse( json );

    free( json );
    shutdown_allow_json5( root );
} @test
