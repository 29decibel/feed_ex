use atom_syndication::Feed;
use serde_json::to_string;

mod atoms {
    rustler::atoms! {
        ok,
        error,
    }
}

use rustler::{Encoder, Env, Term};

#[rustler::nif]
fn parse_rss(env: Env, rss_string: String) -> rustler::NifResult<Term> {
    match rss::Channel::read_from(rss_string.as_bytes()) {
        Ok(chanel) => match to_string(&chanel) {
            Ok(result) => Ok(result.encode(env)),
            Err(_err) => Ok((
                atoms::error(),
                "Native: Can not turn parsed chanel into JSON string",
            )
                .encode(env)),
        },
        Err(_) => Ok((atoms::error(), "Native: Cant not parse given rss string").encode(env)),
    }
}

#[rustler::nif]
fn parse_atom(env: Env, atom_string: String) -> rustler::NifResult<Term> {
    match Feed::read_from(atom_string.as_bytes()) {
        Ok(feed) => match to_string(&feed) {
            Ok(result) => Ok(result.encode(env)),
            Err(_err) => Ok((
                atoms::error(),
                "Native: Can not turn parsed chanel into JSON string",
            )
                .encode(env)),
        },
        Err(_) => Ok((atoms::error(), "Native: Cant not parse given rss string").encode(env)),
    }
}

rustler::init!("Elixir.FeedEx.Native", [parse_rss, parse_atom]);
