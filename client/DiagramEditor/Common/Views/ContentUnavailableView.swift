import SwiftUI

struct ContentUnavailableView<Actions: View>: View {
    var label: String
    var description: String?
    var systemImage: String?
    var actions: Actions?

    init(
        _ label: String,
        description: String? = nil,
        systemImage: String? = nil,
        @ViewBuilder actions: () -> Actions? = { EmptyView() }
    ) {
        self.label = label
        self.description = description
        self.systemImage = systemImage
        self.actions = actions()
    }

    var contentUnavailableView: some View {
        VStack(spacing: 14) {
            VStack(spacing: 5) {
                if systemImage != nil {
                    Image(systemName: systemImage ?? "questionmark.app.dashed")
                        .font(.system(size: 28))
                        .foregroundStyle(.tertiary)
                        .padding(.bottom, 8)
                }
                Text(label)
                    .font(.system(size: 16.5, weight: systemImage != nil ? .bold : .regular))
                if description != nil {
                    Text(description ?? "")
                        .font(.system(size: 10))
                        .multilineTextAlignment(.center)
                }
            }
            if let actionsView = actions {
                HStack { actionsView }
            }
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .controlSize(.small)
    }

    var body: some View {
        if #available(macOS 14, *) {
            contentUnavailableView
                .buttonStyle(.accessoryBarAction)
        } else {
            contentUnavailableView
        }
    }
}
