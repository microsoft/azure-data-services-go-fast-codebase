import { Global } from "@emotion/react";
import React from "react";

interface Style {
  weight?: number | string;
  fontStyle?: string;
  src: {
    local: string;
    eot: string;
    woff2: string;
    woff: string;
    trueType: string;
  };
}

const styles: { [key: string]: Style[] } = {

    
};

const styleString = Object.keys(styles)
  .map((family) =>
    styles[family]
      .map(
        (style) => `
/* latin */
@font-face {
    font-family: '${family}';
    font-style: ${style.fontStyle ?? "normal"};
    font-weight: ${style.weight ?? "normal"};
    font-display: swap;
    src: ${`local('${style.src.local}'),
        url('${style.src.eot}') format('embedded-opentype'),
        url('${style.src.woff2}') format("woff2"),
        url('${style.src.woff}') format('woff'),
        url('${style.src.trueType}') format('truetype')`};
}`
      )
      .join("")
  )
  .join("");

const Fonts = () => <Global styles={styleString} />;

export default Fonts;
