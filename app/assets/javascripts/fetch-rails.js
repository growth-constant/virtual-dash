window.Fetch = ( function( d ){
  'use strict';

  function status( response ){
    if ( response.ok ){
      return response;
    } else {
      var error = new Error( response.statusText || response.status );
      error.response = response;
      throw error;
    }
  }

  function headers( options ){
    options = options || {};
    options.headers = options.headers || {};
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['X-CSRF-Token'] = d.querySelector( 'meta[name="csrf-token"]' ).getAttribute( 'content' );
    return options;
  }

  function credentials( options ){
    if ( options == null ) {
      options = {};
    }

    if ( options.credentials == null ) {
      options.credentials = 'same-origin';
    }

    return options;
  }

  function json( response ){
    return response.json();
  }

  function text( response ){
    return response.text();
  }

  function fetchHTML( url, options ){
    return fetch( url, headers( credentials( options ) ) ).then( status );
  }

  function fetchText( url, options ){
    return fetch( url, headers( credentials( options ) ) ).then( status ).then( text );
  }

  function fetchJSON( url, options ){
    options = headers( credentials( options ) );
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    return fetch( url, options ).then( status ).then( json );
  }

  function postForm( url, form, options ){
    options = headers( credentials( options ) );
    options.body = new FormData( d.querySelector( form ) );
    options.method = 'post';

    return fetch( url, options ).then( status );
  }

  function postJSON( url, body, options ){
    options = headers( credentials( options ) );
    options.body = JSON.stringify( body );
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.method = 'post';

    return fetch( url, options ).then( status ).then( json );
  }

  function uploadFile( url, form, file, options ){
    var data = new FormData( d.querySelector( form ) );
    data.append( 'file', file.files[ 0 ] );

    options = headers( credentials( options ) );
    options.body = data;
    options.method = 'post';

    return fetch( url, options ).then( status );
  }

  return {
    html: fetchHTML
  , json: fetchJSON
  , post: postForm
  , postJSON: postJSON
  , text: fetchText
  , upload: uploadFile };
})( document );