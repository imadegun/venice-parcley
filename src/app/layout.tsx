import type { Metadata } from "next";
import { Josefin_Sans, Montserrat, Bebas_Neue, Mulish, Yellowtail } from "next/font/google";
import "./globals.css";
import { RouteShell } from "@/components/layout/route-shell";

// Custom Typography Fonts
const josefinSans = Josefin_Sans({
  subsets: ["latin"],
  weight: ["400", "600", "700"],
  variable: "--font-josefin",
  display: "swap",
});

const montserrat = Montserrat({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800", "900"],
  variable: "--font-montserrat",
  display: "swap",
});

const bebasNeue = Bebas_Neue({
  subsets: ["latin"],
  weight: ["400"],
  variable: "--font-bebas",
  display: "swap",
});

const mulish = Mulish({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700", "800"],
  variable: "--font-mulish",
  display: "swap",
});

const yellowtail = Yellowtail({
  subsets: ["latin"],
  weight: ["400"],
  variable: "--font-yellowtail",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Venice Parcley - Luxury Artistic Apartments",
  description: "Discover unique artistic apartments in Venice. Luxury accommodations designed for art lovers, creative souls, and discerning travelers.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${josefinSans.variable} ${montserrat.variable} ${bebasNeue.variable} ${mulish.variable} ${yellowtail.variable}`}>
      <body className={`${mulish.className} antialiased min-h-screen flex flex-col font-body`}>
        <RouteShell>{children}</RouteShell>
      </body>
    </html>
  );
}
