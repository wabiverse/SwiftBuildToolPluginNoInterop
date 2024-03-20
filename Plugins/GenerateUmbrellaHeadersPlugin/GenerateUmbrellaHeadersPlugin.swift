/* --------------------------------------------------------------
 * :: :  M  E  T  A  V  E  R  S  E  :                          ::
 * --------------------------------------------------------------
 * This program is free software; you can redistribute it, and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. Check out
 * the GNU General Public License for more details.
 *
 * You should have received a copy for this software license, the
 * GNU General Public License along with this program; or, if not
 * write to the Free Software Foundation, Inc., to the address of
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *       Copyright (C) 2023 Wabi Foundation. All Rights Reserved.
 * --------------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * -------------------------------------------------------------- */

import Foundation
import PackagePlugin

@main
struct GenerateUmbrellaHeadersPlugin: BuildToolPlugin
{
  func createBuildCommands(context: PluginContext, target: Target) throws -> [Command]
  {
    guard let target = target.sourceModule
    else { return [] }

    let includeDir = target.directory.appending("include/\(target.name)").string

    guard FileManager.default.fileExists(atPath: includeDir) == true
    else { return [] }

    var inputFiles: [URL] = try FileManager.default.contentsOfDirectory(
      at: URL(fileURLWithPath: includeDir),
      includingPropertiesForKeys: nil
    )
    inputFiles.removeAll(where: { $0.pathExtension != "h" })

    var headers = inputFiles.map(\.lastPathComponent)
    headers.sort()

    let outputDir = context.pluginWorkDirectory.appending("\(target.name)/include/\(target.name)")
    try FileManager.default.createDirectory(
      atPath: outputDir.string,
      withIntermediateDirectories: true
    )

    do
    {
      // Generate the umbrella header for the C++ module
      try """
      // Generated by GenerateUmbrellaHeadersPlugin
      #ifndef __\(target.name.camelToSnake().uppercased())_GENERATED_UMBRELLA_H__
      #define __\(target.name.camelToSnake().uppercased())_GENERATED_UMBRELLA_H__

      \(headers.map
      {
        """
        // __\(target.name.camelToSnake().uppercased())_\($0.replacingOccurrences(of: ".", with: "_").camelToSnake().uppercased())__
        #include <\(target.name)/\($0)>
        """
      }.joined(separator: "\n"))

      #endif // __\(target.name.camelToSnake().uppercased())_GENERATED_UMBRELLA_H__
      """.write(to: URL(fileURLWithPath: outputDir.appending("\(target.name).h").string), atomically: true, encoding: String.Encoding.utf8)
    }
    catch
    {}

    return [
      .prebuildCommand(
        displayName: "Generating Cxx Umbrella Header for: \(target.name)",
        executable: .init("/usr/bin/touch"),
        arguments: ["\(outputDir.appending("\(target.name).h").string)"],
        outputFilesDirectory: outputDir
      ),
    ]
  }
}

extension String
{
  func camelToSnake() -> String
  {
    let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
    let fullWordsPattern = "([a-z])([A-Z]|[0-9])"
    let digitsFirstPattern = "([0-9])([A-Z])"
    return processCamelCaseRegex(pattern: acronymPattern)?
      .processCamelCaseRegex(pattern: fullWordsPattern)?
      .processCamelCaseRegex(pattern: digitsFirstPattern)?.lowercased() ?? lowercased()
  }

  private func processCamelCaseRegex(pattern: String) -> String?
  {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: count)
    return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
  }
}
