using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;

namespace WebApplication.Framework
{
    public static class EnumerableExtensions
    {
        /// <summary>
        /// Returns a list of non-null items from the sequence of <see cref="Nullable{T}"/>.
        /// This is analogous to F#'s seq.Choose
        /// </summary>
        [Pure]
        public static IEnumerable<T> Choose<T>(this IEnumerable<T?> items) where T : struct 
            => items.Where(x => x.HasValue).Select(x => x.Value);


        /// <summary>
        /// Returns a list of non-null items from the sequence of items after projecting them to a nullable <see cref="Nullable{T}"/>.
        /// This is analogous to F#'s seq.Choose
        /// </summary>
        [Pure]
        public static IEnumerable<U> Choose<T, U>(this IEnumerable<T> items, Func<T, U?> fn) where U : struct
            => items.Select(fn).Where(x => x.HasValue).Select(x => x.Value);

        
        /// <summary>
        /// converts a list of keyvalue pairs into a dictionary
        /// </summary>
        public static IDictionary<TKey, TValue> ToDictionary<TKey, TValue>(this IEnumerable<KeyValuePair<TKey, TValue>> collection) 
            => new Dictionary<TKey, TValue>(collection);

    }
}
