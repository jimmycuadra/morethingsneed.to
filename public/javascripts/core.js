if (typeof MTNT == 'undefined') {
  MTNT = {};
}

// override native implementations for now, they are not compatible with its usage in MTNT
Function.prototype.bind = function() {
  var __method = this, args = Array.prototype.slice.call(arguments), object = args.shift();
  return function() {
    var local_args = args.concat(Array.prototype.slice.call(arguments));
    if (this !== window) local_args.push(this);
    return __method.apply(object, local_args);
  };
};
